$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json
$alerts = $j | Where-Object { $_.rule.id -eq "js/missing-variable-declaration" }
Write-Host "Total alerts: $($alerts.Count)"

$byFile = $alerts | Group-Object { $_.most_recent_instance.location.path }
$totalFixed = 0

foreach ($group in ($byFile | Sort-Object Name)) {
    $relPath = $group.Name
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $relPath.Replace('/', '\')
    if (-not (Test-Path $absPath)) { Write-Host "MISSING: $relPath"; continue }

    $lines = [System.Collections.Generic.List[string]]([System.IO.File]::ReadAllLines($absPath))
    $changed = $false

    # Process alerts in REVERSE line+column order to preserve offsets
    $sorted = $group.Group | Sort-Object { $_.most_recent_instance.location.start_line }, { $_.most_recent_instance.location.start_column } -Descending

    foreach ($alert in $sorted) {
        $loc = $alert.most_recent_instance.location
        $ln = $loc.start_line - 1
        $sc = [Math]::Max(0, $loc.start_column - 1)
        if ($ln -lt 0 -or $ln -ge $lines.Count) { continue }
        $line = $lines[$ln]
        if ($sc -ge $line.Length) { continue }

        $msg = $alert.most_recent_instance.message.text
        # Extract variable name from message: "Variable X is used like a local variable..."
        $varName = if ($msg -match "Variable (\S+) is used") { $Matches[1] } else { "" }
        if (-not $varName) { continue }

        # Verify we're at the right position - the span should start with varName
        $spanStart = $line.Substring($sc)
        if (-not $spanStart.StartsWith($varName)) {
            Write-Host "NOMATCH: var=$varName at [$($spanStart.Substring(0,[Math]::Min(30,$spanStart.Length)))] in $($relPath.Split('/')[-1]):$($loc.start_line)"
            continue
        }

        # Check what comes before - if already 'var ', 'let ', 'const ', skip
        $prefix = if ($sc -ge 4) { $line.Substring($sc-4, 4) } else { $line.Substring(0, $sc) }
        if ($prefix -match '(var|let|const)\s*$') {
            Write-Host "ALREADY_DECL: $varName in $($relPath.Split('/')[-1]):$($loc.start_line)"
            continue
        }

        # Insert 'var ' before the variable name at position sc
        $lines[$ln] = $line.Substring(0, $sc) + "var " + $line.Substring($sc)
        $changed = $true; $totalFixed++
    }

    if ($changed) {
        [System.IO.File]::WriteAllLines($absPath, $lines, [System.Text.UTF8Encoding]::new($false))
        Write-Host "Fixed $($group.Group.Count) in $($relPath.Split('/')[-1])"
    }
}

Write-Host "Total: $totalFixed"
