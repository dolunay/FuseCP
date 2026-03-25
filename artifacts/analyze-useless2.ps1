$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json
$alerts = $j | Where-Object { $_.rule.id -eq "cs/useless-assignment-to-local" }
Write-Host "Count: $($alerts.Count)"

$stale = 0; $real = 0
$realPats = @{}

foreach ($alert in $alerts) {
    $loc = $alert.most_recent_instance.location
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
    if (-not (Test-Path $absPath)) { $stale++; continue }
    $lines = [System.IO.File]::ReadAllLines($absPath)
    $ln = $loc.start_line - 1
    if ($ln -ge $lines.Count) { $stale++; continue }
    $sc = [Math]::Max(0,$loc.start_column-1); $ec = [Math]::Min($loc.end_column-1, $lines[$ln].Length)
    if ($sc -ge $ec) { $stale++; continue }
    
    $span = $lines[$ln].Substring($sc, $ec-$sc)
    # Extract var name from message
    $msg = $alert.most_recent_instance.message.text
    $varName = if ($msg -match "assignment to (\w+) is useless") { $Matches[1] } else { "?" }
    
    # Check if the span contains an assignment with the variable on the LHS
    if ($span -match "^\s*$varName\s*=") {
        $real++
        $pat = $lines[$ln].Trim()
        $patKey = if ($pat.Length -gt 80) { $pat.Substring(0, 80) } else { $pat }
        $k = ""; if ($realPats.ContainsKey($patKey)) { $k = $realPats[$patKey] } else { $k = 0 }
        $realPats[$patKey] = [int]$k + 1
    } else {
        $stale++
    }
}

Write-Host "Real: $real, Stale: $stale"
Write-Host "Top real patterns:"
$realPats.GetEnumerator() | Sort-Object Value -Descending | Select-Object -First 20 | ForEach-Object { Write-Host "  [$($_.Key)]: $($_.Value)" }
