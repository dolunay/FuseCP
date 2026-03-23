$a = Get-Content "artifacts\codeql-open-alerts.json" | ConvertFrom-Json
$r = $a | Where-Object { $_.rule.id -eq "cs/local-not-disposed" }
Write-Host "Total: $($r.Count)"
$r | ForEach-Object {
    $m = $_.most_recent_instance.message.text
    if ($m -match "of type '([^']+)'") { $Matches[1] }
} | Group-Object | Sort-Object Count -Descending | Select-Object -First 20 | ForEach-Object {
    Write-Host "$($_.Count) $($_.Name)"
}
