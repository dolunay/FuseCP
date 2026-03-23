$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json
$alerts = $j | Where-Object { $_.rule.id -eq "js/missing-variable-declaration" }
Write-Host "Count: $($alerts.Count)"

# Group by file and understand patterns
$byFile = $alerts | Group-Object { $_.most_recent_instance.location.path }
Write-Host "Across $($byFile.Count) files"

# Get distinct patterns
$patterns = @{}
foreach ($alert in $alerts) {
    $loc = $alert.most_recent_instance.location
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
    if (-not (Test-Path $absPath)) { continue }
    $lines = [System.IO.File]::ReadAllLines($absPath)
    $ln = $loc.start_line - 1
    if ($ln -ge $lines.Count) { continue }
    $lineStr = $lines[$ln].Trim()
    $k = if ($lineStr.Length -gt 100) { $lineStr.Substring(0,100) } else { $lineStr }
    if (-not $patterns.ContainsKey($k)) { $patterns[$k] = 0 }
    $patterns[$k]++
}

Write-Host "Top patterns:"
$patterns.GetEnumerator() | Sort-Object Value -Descending | Select-Object -First 15 | ForEach-Object {
    Write-Host "  [$($_.Key)]: $($_.Value)"
}
