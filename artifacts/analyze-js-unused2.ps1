$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json
$alerts = $j | Where-Object { $_.rule.id -eq "js/unused-local-variable" }

$fileCounts = $alerts | Group-Object { $_.most_recent_instance.location.path } | Sort-Object Count -Descending
Write-Host "Files with most alerts:"
$fileCounts | Select-Object -First 20 | ForEach-Object {
    Write-Host "  $($_.Count): $($_.Name.Split('/')[-1]) ($($_.Name -replace '^.*?/Sources','/Sources'))"
}

Write-Host ""
Write-Host "First-party files (fcp-*):"
$fileCounts | Where-Object { $_.Name -match 'fcp-' } | ForEach-Object {
    Write-Host "  $($_.Count): $($_.Name.Split('/')[-1])"
}
