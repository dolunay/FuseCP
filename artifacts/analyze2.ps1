$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json

Write-Host "=== constant-condition ==="
$cc = $j | Where-Object { $_.rule.id -eq "cs/constant-condition" }
Write-Host "Count: $($cc.Count)"
$cc.most_recent_instance.message.text | Sort-Object -Unique | ForEach-Object { Write-Host "MSG: $_" }
Write-Host "--- samples ---"
$cc | Select-Object -First 5 | ForEach-Object {
    $loc = $_.most_recent_instance.location
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
    if (Test-Path $absPath) {
        $lines = [System.IO.File]::ReadAllLines($absPath)
        $ln = $loc.start_line - 1; $sc = [Math]::Max(0,$loc.start_column-1); $ec = [Math]::Min($loc.end_column-1, $lines[$ln].Length)
        Write-Host "FILE: $($loc.path.Split('/')[-1]) L$($loc.start_line)"
        Write-Host "MSG: $($_.most_recent_instance.message.text)"
        if ($sc -lt $ec) { Write-Host "SPAN: [$($lines[$ln].Substring($sc,$ec-$sc))]" } else { Write-Host "LINE: [$($lines[$ln].Trim())]" }
    }
}

Write-Host ""
Write-Host "=== local-shadows-member ==="
$ls = $j | Where-Object { $_.rule.id -eq "cs/local-shadows-member" }
Write-Host "Count: $($ls.Count)"
$ls.most_recent_instance.message.text | Select-Object -First 5 | ForEach-Object { Write-Host "MSG: $_" }

Write-Host ""
Write-Host "=== nested-if-statements ==="
$ni = $j | Where-Object { $_.rule.id -eq "cs/nested-if-statements" }
Write-Host "Count: $($ni.Count)"
$ni.most_recent_instance.message.text | Sort-Object -Unique | Select-Object -First 3 | ForEach-Object { Write-Host "MSG: $_" }

Write-Host ""
Write-Host "=== class-name-matches-base-class ==="
$cn = $j | Where-Object { $_.rule.id -eq "cs/class-name-matches-base-class" }
Write-Host "Count: $($cn.Count)"
$cn.most_recent_instance.message.text | Sort-Object -Unique | Select-Object -First 3 | ForEach-Object { Write-Host "MSG: $_" }
