$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json

Write-Host "=== js/syntax-error ==="
$se = $j | Where-Object { $_.rule.id -eq "js/syntax-error" }
Write-Host "Count: $($se.Count)"
$se | Group-Object { $_.most_recent_instance.location.path.Split('/')[-1] } | Sort-Object Count -Descending | Select-Object -First 10 | ForEach-Object {
    Write-Host "  $($_.Count): $($_.Name)"
}

Write-Host ""
Write-Host "=== js/unused-local-variable in fcp-* ==="  
$uv = $j | Where-Object { $_.rule.id -eq "js/unused-local-variable" -and $_.most_recent_instance.location.path -match 'fcp-' }
Write-Host "Count: $($uv.Count)"
$uv | Select-Object -First 10 | ForEach-Object {
    $loc = $_.most_recent_instance.location
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
    if (Test-Path $absPath) {
        $lines = [System.IO.File]::ReadAllLines($absPath)
        $ln = $loc.start_line - 1
        $sc = [Math]::Max(0,$loc.start_column-1); $ec = [Math]::Min($loc.end_column-1, $lines[$ln].Length)
        Write-Host "MSG: $($_.most_recent_instance.message.text)"
        Write-Host "  L$($loc.start_line): $($lines[$ln].Trim())"
    }
}
