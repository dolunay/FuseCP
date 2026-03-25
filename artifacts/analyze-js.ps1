$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json

Write-Host "=== js/unused-local-variable ==="
$js = $j | Where-Object { $_.rule.id -eq "js/unused-local-variable" }
Write-Host "Count: $($js.Count)"
$js | Select-Object -First 8 | ForEach-Object {
    $loc = $_.most_recent_instance.location
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
    if (Test-Path $absPath) {
        $lines = [System.IO.File]::ReadAllLines($absPath)
        $ln = $loc.start_line - 1; $sc = [Math]::Max(0,$loc.start_column-1); $ec = [Math]::Min($loc.end_column-1, $lines[$ln].Length)
        Write-Host "MSG: $($_.most_recent_instance.message.text)"
        if ($sc -lt $ec) { Write-Host "SPAN: [$($lines[$ln].Substring($sc,$ec-$sc))]" }
        Write-Host "  L$($loc.start_line): $($lines[$ln].Trim())"
    }
}

Write-Host ""
Write-Host "=== inefficient-containskey ==="
$ick = $j | Where-Object { $_.rule.id -eq "cs/inefficient-containskey" }
Write-Host "Count: $($ick.Count)"
$ick | Select-Object -First 5 | ForEach-Object {
    $loc = $_.most_recent_instance.location
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
    if (Test-Path $absPath) {
        $lines = [System.IO.File]::ReadAllLines($absPath)
        $ln = $loc.start_line - 1; $sc = [Math]::Max(0,$loc.start_column-1); $ec = [Math]::Min($loc.end_column-1, $lines[$ln].Length)
        Write-Host "MSG: $($_.most_recent_instance.message.text)"
        if ($sc -lt $ec) { Write-Host "SPAN: [$($lines[$ln].Substring($sc,$ec-$sc))]" }
        Write-Host "  L$($loc.start_line): $($lines[$ln].Trim())"
        $startL = [Math]::Max(0, $ln); $endL = [Math]::Min($lines.Count-1, $ln+4)
        $startL..$endL | ForEach-Object { Write-Host "  L$($_+1): $($lines[$_])" }
    }
}

Write-Host ""
Write-Host "=== js/missing-variable-declaration ==="
$mvd = $j | Where-Object { $_.rule.id -eq "js/missing-variable-declaration" }
Write-Host "Count: $($mvd.Count)"
$mvd | Select-Object -First 5 | ForEach-Object {
    $loc = $_.most_recent_instance.location
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
    if (Test-Path $absPath) {
        $lines = [System.IO.File]::ReadAllLines($absPath)
        $ln = $loc.start_line - 1; $sc = [Math]::Max(0,$loc.start_column-1); $ec = [Math]::Min($loc.end_column-1, $lines[$ln].Length)
        Write-Host "MSG: $($_.most_recent_instance.message.text)"
        if ($sc -lt $ec) { Write-Host "SPAN: [$($lines[$ln].Substring($sc,$ec-$sc))]" }
        Write-Host "  L$($loc.start_line): $($lines[$ln].Trim())"
    }
}
