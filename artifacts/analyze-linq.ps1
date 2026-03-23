$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json

Write-Host "=== missed-where ==="
$mw = $j | Where-Object { $_.rule.id -eq "cs/linq/missed-where" }
Write-Host "Count: $($mw.Count)"
$mw | Select-Object -First 5 | ForEach-Object {
    $loc = $_.most_recent_instance.location
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
    if (Test-Path $absPath) {
        $lines = [System.IO.File]::ReadAllLines($absPath)
        $ln = $loc.start_line - 1; $sc = [Math]::Max(0,$loc.start_column-1); $ec = [Math]::Min($loc.end_column-1, $lines[$ln].Length)
        Write-Host "MSG: $($_.most_recent_instance.message.text)"
        if ($sc -lt $ec) { Write-Host "SPAN[$($loc.start_line)]: [$($lines[$ln].Substring($sc,$ec-$sc))]" }
    }
}

Write-Host ""
Write-Host "=== missed-select ==="
$ms = $j | Where-Object { $_.rule.id -eq "cs/linq/missed-select" }
Write-Host "Count: $($ms.Count)"
$ms | Select-Object -First 5 | ForEach-Object {
    $loc = $_.most_recent_instance.location
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
    if (Test-Path $absPath) {
        $lines = [System.IO.File]::ReadAllLines($absPath)
        $ln = $loc.start_line - 1; $sc = [Math]::Max(0,$loc.start_column-1); $ec = [Math]::Min($loc.end_column-1, $lines[$ln].Length)
        Write-Host "MSG: $($_.most_recent_instance.message.text)"
        if ($sc -lt $ec) { Write-Host "SPAN[$($loc.start_line)]: [$($lines[$ln].Substring($sc,$ec-$sc))]" }
    }
}

Write-Host ""
Write-Host "=== useless-assignment ==="
$ua = $j | Where-Object { $_.rule.id -eq "cs/useless-assignment-to-local" }
Write-Host "Count: $($ua.Count)"
$ua | Select-Object -First 5 | ForEach-Object {
    Write-Host "MSG: $($_.most_recent_instance.message.text)"
}

Write-Host ""
Write-Host "=== empty-catch-block ==="
$ec = $j | Where-Object { $_.rule.id -eq "cs/empty-catch-block" }
Write-Host "Count: $($ec.Count)"
$ec | Select-Object -First 3 | ForEach-Object {
    $loc = $_.most_recent_instance.location
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
    if (Test-Path $absPath) {
        $lines = [System.IO.File]::ReadAllLines($absPath)
        $ln = $loc.start_line - 1; $sc = [Math]::Max(0,$loc.start_column-1); $ec2 = [Math]::Min($loc.end_column-1, $lines[$ln].Length)
        Write-Host "MSG: $($_.most_recent_instance.message.text)"
        $startL = [Math]::Max(0, $ln-1); $endL = [Math]::Min($lines.Count-1, $ln+3)
        $startL..$endL | ForEach-Object { Write-Host "  L$($_+1): $($lines[$_])" }
    }
}
