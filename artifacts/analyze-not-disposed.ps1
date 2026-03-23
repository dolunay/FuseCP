$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json
$alerts = $j | Where-Object { $_.rule.id -eq "cs/local-not-disposed" }
Write-Host "Count: $($alerts.Count)"

# Understand what types are created
$types = @{}
foreach ($alert in $alerts) {
    $msg = $alert.most_recent_instance.message.text
    $typeName = if ($msg -match "Disposable '(.+)' is created") { $Matches[1] } else { "?" }
    if (-not $types.ContainsKey($typeName)) { $types[$typeName] = 0 }
    $types[$typeName]++
}
Write-Host "Types by frequency:"
$types.GetEnumerator() | Sort-Object Value -Descending | ForEach-Object { Write-Host "  $($_.Key): $($_.Value)" }

Write-Host ""
Write-Host "=== Sample lines ==="
$alerts | Select-Object -First 10 | ForEach-Object {
    $loc = $_.most_recent_instance.location
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
    if (Test-Path $absPath) {
        $lines = [System.IO.File]::ReadAllLines($absPath)
        $ln = $loc.start_line - 1; $sc = [Math]::Max(0,$loc.start_column-1); $ec = [Math]::Min($loc.end_column-1, $lines[$ln].Length)
        $msg = $_.most_recent_instance.message.text
        $typeName = if ($msg -match "Disposable '(.+)' is created") { $Matches[1] } else { "?" }
        Write-Host "TYPE:$typeName FILE:$($loc.path.Split('/')[-1]) L$($loc.start_line)"
        Write-Host "  $($lines[$ln].Trim())"
    }
}
