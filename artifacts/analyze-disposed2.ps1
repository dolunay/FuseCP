$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json
$alerts = $j | Where-Object { $_.rule.id -eq "cs/local-not-disposed" }
Write-Host "Remaining types:"
$types = @{}
foreach ($alert in $alerts) {
    $msg = $alert.most_recent_instance.message.text
    $typeName = if ($msg -match "Disposable '(.+)' is created") { $Matches[1] } else { "?" }
    if (-not $types.ContainsKey($typeName)) { $types[$typeName] = 0 }
    $types[$typeName]++
}
$types.GetEnumerator() | Sort-Object Value -Descending | ForEach-Object { Write-Host "  $($_.Key): $($_.Value)" }

# Sample DirectoryEntry patterns
Write-Host ""
Write-Host "=== DirectoryEntry samples ==="
$alerts | Where-Object { $_.most_recent_instance.message.text -match "'DirectoryEntry'" } | Select-Object -First 5 | ForEach-Object {
    $loc = $_.most_recent_instance.location
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
    if (Test-Path $absPath) {
        $lines = [System.IO.File]::ReadAllLines($absPath)
        $ln = $loc.start_line - 1
        $startL = [Math]::Max(0, $ln-1); $endL = [Math]::Min($lines.Count-1, $ln+4)
        Write-Host "--- $($loc.path.Split('/')[-1]) L$($loc.start_line) ---"
        $startL..$endL | ForEach-Object { Write-Host "  L$($_+1): $($lines[$_])" }
    }
}

# Sample SqlCommand patterns
Write-Host ""
Write-Host "=== SqlCommand / MySqlCommand samples ==="
$alerts | Where-Object { $_.most_recent_instance.message.text -match "'(Sql|MySql)Command'" } | Select-Object -First 3 | ForEach-Object {
    $loc = $_.most_recent_instance.location
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
    if (Test-Path $absPath) {
        $lines = [System.IO.File]::ReadAllLines($absPath)
        $ln = $loc.start_line - 1
        $startL = [Math]::Max(0, $ln-1); $endL = [Math]::Min($lines.Count-1, $ln+5)
        Write-Host "--- $($loc.path.Split('/')[-1]) L$($loc.start_line) ---"
        $startL..$endL | ForEach-Object { Write-Host "  L$($_+1): $($lines[$_])" }
    }
}
