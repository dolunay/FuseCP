$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json
$alerts = $j | Where-Object { $_.rule.id -eq "cs/missed-readonly-modifier" }
Write-Host "Alerts: $($alerts.Count)"

$count = 0
foreach ($a in $alerts) {
    $path = "C:\git\FuseCPDevOPS-FuseCP\" + $a.most_recent_instance.location.path.Replace('/', '\')
    if (-not (Test-Path $path)) { continue }
    $ln = $a.most_recent_instance.location.start_line - 1
    $lines = Get-Content $path
    if ($ln -ge $lines.Count) { continue }
    $line = $lines[$ln]
    if ($line -match '\breadonly\b') { continue }
    Write-Host "L$($ln+1): [$($line.Trim())]"
    $count++
    if ($count -ge 10) { break }
}
Write-Host "Shown: $count"
