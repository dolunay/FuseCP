$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json

$rules = @("cs/useless-cast-to-self", "cs/useless-upcast", "cs/useless-tostring-call")
$alerts = $j | Where-Object { $rules -contains $_.rule.id }
Write-Host "Total alerts to fix: $($alerts.Count)"

$byFile = $alerts | Group-Object { $_.most_recent_instance.location.path }
$totalFixed = 0

foreach ($group in $byFile) {
    $relPath = $group.Name
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $relPath.Replace('/', '\')
    if (-not (Test-Path $absPath)) { Write-Host "MISSING: $relPath"; continue }

    $lines = [System.IO.File]::ReadAllLines($absPath)
    $changed = $false

    # Process alerts sorted in REVERSE line order, then reverse column order
    $sorted = $group.Group | Sort-Object { $_.most_recent_instance.location.start_line }, { $_.most_recent_instance.location.start_column } -Descending

    foreach ($alert in $sorted) {
        $loc = $alert.most_recent_instance.location
        $ln = $loc.start_line - 1
        $sc = [Math]::Max(0, $loc.start_column - 1)
        $ec = $loc.end_column - 1
        if ($ln -lt 0 -or $ln -ge $lines.Count) { continue }
        $line = $lines[$ln]
        if ($ec -gt $line.Length) { $ec = $line.Length }
        if ($sc -ge $ec) { continue }

        $spanText = $line.Substring($sc, $ec - $sc)
        $fixedSpan = $spanText

        switch ($alert.rule.id) {
            "cs/useless-tostring-call" {
                # Remove .ToString() at end of span
                if ($fixedSpan -match '(.+)\.ToString\(\)$') {
                    $fixedSpan = $Matches[1]
                }
            }
            { $_ -in "cs/useless-cast-to-self", "cs/useless-upcast" } {
                # Remove leading C-style cast: (TypeName) 
                if ($fixedSpan -match '^\(([^)]+)\)\s*(.+)$') {
                    $fixedSpan = $Matches[2]
                }
                # Remove trailing 'as TypeName' 
                elseif ($fixedSpan -match '^(.+?)\s+as\s+\S+$') {
                    $fixedSpan = $Matches[1]
                }
            }
        }

        if ($fixedSpan -ne $spanText) {
            $lines[$ln] = $line.Substring(0, $sc) + $fixedSpan + $line.Substring($ec)
            $changed = $true
            $totalFixed++
        } else {
            Write-Host "NOMATCH [$($alert.rule.id)]: [$spanText]"
        }
    }

    if ($changed) {
        [System.IO.File]::WriteAllLines($absPath, $lines, [System.Text.UTF8Encoding]::new($false))
        Write-Host "Fixed $($group.Group.Count) in $($relPath.Split('/')[-1])"
    }
}
Write-Host "Total fixed: $totalFixed"
