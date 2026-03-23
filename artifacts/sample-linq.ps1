$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json
$alerts = $j | Where-Object { $_.rule.id -eq "cs/linq/missed-where" }
Write-Host "=== linq/missed-where samples ==="
$alerts | Select-Object -First 4 | ForEach-Object {
    $loc = $_.most_recent_instance.location
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
    if (Test-Path $absPath) {
        $lines = [System.IO.File]::ReadAllLines($absPath)
        $ln = $loc.start_line - 1
        $startL = $ln; $endL = [Math]::Min($lines.Count-1, $ln+10)
        Write-Host "--- $($loc.path.Split('/')[-1]) L$($loc.start_line) ---"
        $startL..$endL | ForEach-Object { Write-Host "  L$($_+1): $($lines[$_])" }
        Write-Host ""
    }
}
Write-Host "=== linq/missed-select samples ==="
$alerts2 = $j | Where-Object { $_.rule.id -eq "cs/linq/missed-select" }
$alerts2 | Select-Object -First 3 | ForEach-Object {
    $loc = $_.most_recent_instance.location
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
    if (Test-Path $absPath) {
        $lines = [System.IO.File]::ReadAllLines($absPath)
        $ln = $loc.start_line - 1
        $startL = $ln; $endL = [Math]::Min($lines.Count-1, $ln+8)
        Write-Host "--- $($loc.path.Split('/')[-1]) L$($loc.start_line) ---"
        $startL..$endL | ForEach-Object { Write-Host "  L$($_+1): $($lines[$_])" }
        Write-Host ""
    }
}
