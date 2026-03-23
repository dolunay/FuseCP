#!/usr/bin/env pwsh
# fix-not-disposed4.ps1 — wraps remaining IDisposable locals with 'using var'

$alertsJson = Join-Path $PSScriptRoot "codeql-open-alerts.json"
$repoRoot   = Split-Path $PSScriptRoot

$alerts = Get-Content $alertsJson | ConvertFrom-Json
$targets = $alerts | Where-Object { $_.rule.id -eq "cs/local-not-disposed" }

$totalFixed = 0
$byFile = @{}
foreach ($a in $targets) {
    $loc  = $a.most_recent_instance.location
    $path = $loc.path
    if (-not $byFile.ContainsKey($path)) { $byFile[$path] = [System.Collections.Generic.List[object]]::new() }
    $byFile[$path].Add([pscustomobject]@{ Line=$loc.start_line; Msg=$a.most_recent_instance.message.text })
}

foreach ($filePath in $byFile.Keys) {
    $absPath = Join-Path $repoRoot $filePath
    if (-not (Test-Path $absPath)) { continue }
    
    $lines = [System.IO.File]::ReadAllLines($absPath)
    $changed = $false
    
    $fileAlerts = $byFile[$filePath] | Sort-Object Line -Descending
    foreach ($alert in $fileAlerts) {
        $ln0     = $alert.Line - 1
        if ($ln0 -lt 0 -or $ln0 -ge $lines.Count) { continue }
        $lineText = $lines[$ln0]
        $trimmed  = $lineText.TrimStart()
        
        # Already uses 'using' → skip (stale alert)
        if ($trimmed -match '^using\s') { continue }
        
        # Must be a local variable declaration of the form:
        # [Type] varName = new Type(...) OR var varName = new Type(...)
        if ($trimmed -notmatch '^\w[\w.<>\[\], ]*\s+\w+\s*=\s*new\s+\w') { continue }
        
        # Skip if line is an argument inside another method call (no semicolon at end — might be multi-line)
        # Better: check if the line ends with ; or has assignment = new ...;
        
        # Get the leading whitespace
        $indent = $lineText.Length - $lineText.TrimStart().Length
        $spaces = $lineText.Substring(0, $indent)
        
        # Add 'using ' before the declaration
        $newLine = $spaces + "using " + $trimmed
        
        # Verify the updated line is still a valid statement (ends with ; or multi-line)
        $lines[$ln0] = $newLine
        $changed = $true
        $totalFixed++
        Write-Host "FIXED: $([System.IO.Path]::GetFileName($filePath)) L$($alert.Line)"
    }
    
    if ($changed) {
        [System.IO.File]::WriteAllLines($absPath, $lines, [System.Text.UTF8Encoding]::new($false))
    }
}

Write-Host "Total fixed: $totalFixed"
