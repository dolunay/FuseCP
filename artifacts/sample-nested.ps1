$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json

Write-Host "=== nested-if samples ==="
$ni = $j | Where-Object { $_.rule.id -eq "cs/nested-if-statements" }
$ni | Select-Object -First 6 | ForEach-Object {
    $loc = $_.most_recent_instance.location
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
    if (Test-Path $absPath) {
        $lines = [System.IO.File]::ReadAllLines($absPath)
        $ln = $loc.start_line - 1
        $startL = $ln; $endL = [Math]::Min($lines.Count-1, $ln+12)
        Write-Host "--- $($loc.path.Split('/')[-1]) L$($loc.start_line) ---"
        $startL..$endL | ForEach-Object { Write-Host "  L$($_+1): $($lines[$_])" }
        Write-Host ""
    }
}
