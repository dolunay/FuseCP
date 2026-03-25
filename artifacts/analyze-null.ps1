$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json
$alerts = $j | Where-Object { $_.rule.id -eq "cs/dereferenced-value-may-be-null" }
Write-Host "Count: $($alerts.Count)"

# Get distinct message patterns
$msgs = $alerts.most_recent_instance.message.text | Sort-Object -Unique
Write-Host "Message patterns:"
$msgs | Select-Object -First 15 | ForEach-Object { Write-Host "  $_" }

Write-Host ""
Write-Host "=== Sample spans ==="
$alerts | Select-Object -First 10 | ForEach-Object {
    $loc = $_.most_recent_instance.location
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
    if (Test-Path $absPath) {
        $lines = [System.IO.File]::ReadAllLines($absPath)
        $ln = $loc.start_line - 1; $sc = [Math]::Max(0,$loc.start_column-1); $ec = [Math]::Min($loc.end_column-1, $lines[$ln].Length)
        Write-Host "FILE: $($loc.path.Split('/')[-1]) L$($loc.start_line)"
        Write-Host "MSG: $($_.most_recent_instance.message.text)"
        if ($sc -lt $ec) { Write-Host "SPAN: [$($lines[$ln].Substring($sc,$ec-$sc))]" }
        Write-Host "  L$($loc.start_line): $($lines[$ln].Trim())"
    }
}
