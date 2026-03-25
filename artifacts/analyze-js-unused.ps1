$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json
$alerts = $j | Where-Object { $_.rule.id -eq "js/unused-local-variable" }
Write-Host "Count: $($alerts.Count)"

# Group by file
$byFile = $alerts | Group-Object { $_.most_recent_instance.location.path }
Write-Host "Across $($byFile.Count) files"

# Check if any are already fixed (stale)
$stale = 0; $real = 0
$realPatterns = @{}

foreach ($alert in $alerts) {
    $loc = $alert.most_recent_instance.location
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
    if (-not (Test-Path $absPath)) { $stale++; continue }
    $lines = [System.IO.File]::ReadAllLines($absPath)
    $ln = $loc.start_line - 1
    if ($ln -ge $lines.Count) { $stale++; continue }
    $sc = [Math]::Max(0, $loc.start_column - 1)
    $ec = [Math]::Min($loc.end_column - 1, $lines[$ln].Length)
    if ($sc -ge $ec) { $stale++; continue }
    $span = $lines[$ln].Substring($sc, $ec-$sc)
    $msg = $alert.most_recent_instance.message.text
    $varName = if ($msg -match "Unused variable (.+)\.") { $Matches[1] } else { "?" }
    if ($span -eq $varName) {
        $real++
        $lineStr = $lines[$ln].Trim()
        $k = if ($lineStr.Length -gt 100) { $lineStr.Substring(0,100) } else { $lineStr }
        if (-not $realPatterns.ContainsKey($k)) { $realPatterns[$k] = 0 }
        $realPatterns[$k]++
    } else {
        $stale++
        Write-Host "STALE: span=[$span] var=$varName in $($loc.path.Split('/')[-1]):$($loc.start_line)"
    }
}

Write-Host "Real: $real, Stale: $stale"
Write-Host "Top patterns:"
$realPatterns.GetEnumerator() | Sort-Object Value -Descending | Select-Object -First 15 | ForEach-Object {
    Write-Host "  [$($_.Key)]: $($_.Value)"
}
