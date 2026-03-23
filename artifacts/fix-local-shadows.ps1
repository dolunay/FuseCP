#!/usr/bin/env pwsh
# fix-local-shadows.ps1 — rename local variables that shadow class members

$alertsJson = Join-Path $PSScriptRoot "codeql-open-alerts.json"
$repoRoot   = Split-Path $PSScriptRoot

$alerts = Get-Content $alertsJson | ConvertFrom-Json
$targets = $alerts | Where-Object {
    $_.rule.id -eq "cs/local-shadows-member" -and
    $_.most_recent_instance.location.path -notlike "*.g.cs" -and
    $_.most_recent_instance.location.path -notlike "*WebServices/FuseCP.Build*"
}

Write-Host "Total: $($targets.Count)"

# Group by file so we process each file once (in reverse line order)
$byFile = @{}
foreach ($a in $targets) {
    $loc  = $a.most_recent_instance.location
    $path = $loc.path
    if (-not $byFile.ContainsKey($path)) { $byFile[$path] = [System.Collections.Generic.List[object]]::new() }
    $byFile[$path].Add([pscustomobject]@{
        Line    = $loc.start_line
        Col     = $loc.start_column
        Message = $a.most_recent_instance.message.text
    })
}

$totalFixed = 0

function Get-VarName([string]$msg) {
    if ($msg -match "variable '([^']+)' shadows") { return $Matches[1] }
    return $null
}

function New-LocalName([string]$varName) {
    # Prefix with 'local', capitalize first letter of original
    if ($varName -match '^[A-Z_]') {
        return "local_$varName"
    }
    $cap = $varName.Substring(0,1).ToUpper() + $varName.Substring(1)
    return "local$cap"
}

function Is-InStringLiteral([string]$line, [int]$pos) {
    # Very rough heuristic: count unescaped " before pos
    $inStr = $false
    for ($k = 0; $k -lt $pos -and $k -lt $line.Length; $k++) {
        if ($line[$k] -eq '"') { $inStr = -not $inStr }
    }
    return $inStr
}

function Count-Braces-InLine([string]$line) {
    # Count { and } not inside string literals
    $opens = 0; $closes = 0; $inStr = $false
    for ($k = 0; $k -lt $line.Length; $k++) {
        $c = $line[$k]
        if ($c -eq '"') { $inStr = -not $inStr }
        elseif (-not $inStr) {
            if ($c -eq '{') { $opens++ }
            elseif ($c -eq '}') { $closes++ }
        }
    }
    return @($opens, $closes)
}

function Is-Parameter([string]$line, [int]$col1based) {
    # Check if the variable at col is a method parameter
    # by counting ( and ) before the column position
    $prefix = if ($col1based -le $line.Length) { $line.Substring(0, $col1based - 1) } else { $line }
    $opens = ($prefix.ToCharArray() | Where-Object { $_ -eq '(' }).Count
    $closes = ($prefix.ToCharArray() | Where-Object { $_ -eq ')' }).Count
    return $opens -gt $closes
}

function Find-MatchingClose([string[]]$lines, [int]$fromLine0) {
    # Find the line with the matching } starting from the { opened on/after fromLine0
    $depth = 0
    $started = $false
    for ($i = $fromLine0; $i -lt $lines.Count; $i++) {
        $bc = Count-Braces-InLine $lines[$i]
        $opens = $bc[0]; $closes = $bc[1]
        foreach ($iter in 1..$([Math]::Max($opens, $closes))) {
            # This simplified approach: just process net balance
            break
        }
        $net = $opens - $closes
        if (-not $started) {
            if ($opens -gt 0) { $started = $true; $depth = $opens - $closes }
        } else {
            $depth += $net
        }
        if ($started -and $depth -le 0) { return $i }
    }
    return -1
}

function Find-Scope([string[]]$lines, [int]$declLine0, [int]$col1based) {
    # Returns [scopeStart0, scopeEnd0] 0-based indices
    # If it's a method parameter, scan FORWARD for the body { }
    # If it's a local variable, scan backward for enclosing { }

    $isParam = Is-Parameter $lines[$declLine0] $col1based

    if ($isParam) {
        # Forward scan: find the first { after the decl line
        $bodyStart0 = -1
        for ($i = $declLine0; $i -lt [Math]::Min($lines.Count, $declLine0 + 20); $i++) {
            $bc = Count-Braces-InLine $lines[$i]
            if ($bc[0] -gt 0) { $bodyStart0 = $i; break }
        }
        if ($bodyStart0 -lt 0) { return @(-1, -1) }
        $bodyEnd0 = Find-MatchingClose $lines $bodyStart0
        # Include the declaration line itself in rename range
        return @($declLine0, $bodyEnd0)
    }

    # Local variable: backward scan for enclosing {
    $depth = 0
    $scopeStart0 = -1
    for ($i = $declLine0; $i -ge 0; $i--) {
        $bc = Count-Braces-InLine $lines[$i]
        # Going backward: } is +1, { is -1
        foreach ($ignored in 1..1) {
            $opens = $bc[0]; $closes = $bc[1]
            # process right-to-left within the line (simulate by: right side is visited first when going backward)
            # Simplified: just process net balance directionally
            for ($j = 1; $j -le $closes; $j++) { $depth++ }
            for ($j = 1; $j -le $opens; $j++) {
                $depth--
                if ($depth -lt 0) { $scopeStart0 = $i; break }
            }
        }
        if ($scopeStart0 -ge 0) { break }
    }
    if ($scopeStart0 -lt 0) { return @(-1, -1) }

    $scopeEnd0 = Find-MatchingClose $lines $scopeStart0
    return @($scopeStart0, $scopeEnd0)
}

foreach ($filePath in $byFile.Keys) {
    $absPath = Join-Path $repoRoot $filePath
    if (-not (Test-Path $absPath)) { Write-Host "SKIP (not found): $filePath"; continue }

    $lines = [System.IO.File]::ReadAllLines($absPath)

    # Sort alerts for this file in REVERSE line order to keep indices stable
    $fileAlerts = $byFile[$filePath] | Sort-Object Line -Descending

    $changed = $false
    foreach ($alert in $fileAlerts) {
        $ln0    = $alert.Line - 1   # 0-based
        $varName = Get-VarName $alert.Message
        if (-not $varName) { continue }

        $newName = New-LocalName $varName

        # Find enclosing scope
        $scope = Find-Scope $lines $ln0 $alert.Col
        $start0 = $scope[0]
        $end0   = $scope[1]
        if ($start0 -lt 0 -or $end0 -lt 0) {
            Write-Host "SKIP (no scope): $filePath L$($alert.Line)"
            continue
        }

        # Safety: skip if scope is larger than 100 lines (might be class-level, too risky)
        if (($end0 - $start0) -gt 100) {
            Write-Host "SKIP (scope too wide, $($end0-$start0) lines): $filePath L$($alert.Line) '$varName' scope L$($start0+1)-L$($end0+1)"
            continue
        }

        $renameFrom = $start0
        $renameTo   = $end0

        # Do word-boundary rename within range
        # Exclude matches preceded by a dot (member access) or a word char
        $pattern = "(?<![.\w])$([regex]::Escape($varName))(?!\w)"
        $replacements = 0
        for ($i = $renameFrom; $i -le $renameTo; $i++) {
            $original = $lines[$i]
            $updated  = [regex]::Replace($original, $pattern, $newName)
            if ($updated -ne $original) {
                $lines[$i] = $updated
                $replacements++
                $changed = $true
            }
        }

        if ($replacements -gt 0) {
            Write-Host "RENAMED: $([System.IO.Path]::GetFileName($filePath)) L$($alert.Line) [$varName -> $newName] ($replacements lines)"
            $totalFixed++
        } else {
            Write-Host "NO-MATCH: $filePath L$($alert.Line) '$varName' not found in scope L$($start0+1)-L$($end0+1)"
        }
    }

    if ($changed) {
        [System.IO.File]::WriteAllLines($absPath, $lines, [System.Text.UTF8Encoding]::new($false))
    }
}

Write-Host "Total renamed: $totalFixed"
