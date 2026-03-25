$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json

Write-Host "=== catch-of-all-exceptions ==="
$coa = $j | Where-Object { $_.rule.id -eq "cs/catch-of-all-exceptions" }
Write-Host "Count: $($coa.Count)"
$msgs = $coa.most_recent_instance.message.text | Sort-Object -Unique
$msgs | ForEach-Object { Write-Host "MSG: $_" }

Write-Host "--- sample spans ---"
$coa | Select-Object -First 8 | ForEach-Object {
    $loc = $_.most_recent_instance.location
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
    if (Test-Path $absPath) {
        $lines = [System.IO.File]::ReadAllLines($absPath)
        $ln = $loc.start_line - 1; $sc = [Math]::Max(0,$loc.start_column-1); $ec = [Math]::Min($loc.end_column-1, $lines[$ln].Length)
        Write-Host "FILE: $($loc.path.Split('/')[-1]) L$($loc.start_line)"
        if ($sc -lt $ec) { Write-Host "SPAN: [$($lines[$ln].Substring($sc,$ec-$sc))]" }
        Write-Host "MSG: $($_.most_recent_instance.message.text)"
        $startL = [Math]::Max(0, $ln-1); $endL = [Math]::Min($lines.Count-1, $ln+3)
        $startL..$endL | ForEach-Object { Write-Host "  L$($_+1): $($lines[$_])" }
    }
}

Write-Host ""
Write-Host "=== local-not-disposed ==="
$lnd = $j | Where-Object { $_.rule.id -eq "cs/local-not-disposed" }
Write-Host "Count: $($lnd.Count)"
$msgs2 = $lnd.most_recent_instance.message.text | Sort-Object -Unique | Select-Object -First 5
$msgs2 | ForEach-Object { Write-Host "MSG: $_" }
$lnd | Select-Object -First 4 | ForEach-Object {
    $loc = $_.most_recent_instance.location
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
    if (Test-Path $absPath) {
        $lines = [System.IO.File]::ReadAllLines($absPath)
        $ln = $loc.start_line - 1; $sc = [Math]::Max(0,$loc.start_column-1); $ec = [Math]::Min($loc.end_column-1, $lines[$ln].Length)
        if ($sc -lt $ec) { Write-Host "SPAN: [$($lines[$ln].Substring($sc,$ec-$sc))] in $($loc.path.Split('/')[-1]) L$($loc.start_line)" }
        Write-Host "  L$($loc.start_line): $($lines[$ln].Trim())"
    }
}
