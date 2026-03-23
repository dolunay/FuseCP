$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json
$alerts = $j | Where-Object { $_.rule.id -eq "cs/empty-catch-block" }
Write-Host "Count: $($alerts.Count)"

$singleLine = 0; $multiLine = 0

foreach ($alert in $alerts) {
    $loc = $alert.most_recent_instance.location
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
    if (-not (Test-Path $absPath)) { continue }
    $lines = [System.IO.File]::ReadAllLines($absPath)
    
    # Find the catch line
    $catchLn = $loc.start_line - 1
    $catchLine = $lines[$catchLn].Trim()
    
    # Count lines until closing brace
    $i = $catchLn
    $depth = 0
    $started = $false
    $bodyLines = @()
    while ($i -lt $lines.Count) {
        $l = $lines[$i].Trim()
        foreach ($c in $l.ToCharArray()) { 
            if ($c -eq '{') { $depth++; $started = $true }
            elseif ($c -eq '}') { $depth-- }
        }
        if ($started -and $depth -le 0) { break }
        $bodyLines += $lines[$i]
        $i++
    }
    
    $span = $i - $catchLn + 1
    if ($span -le 1) { $singleLine++ } else { $multiLine++ }
}

Write-Host "Single line (catch { }): $singleLine"
Write-Host "Multi line: $multiLine"

# Show the first 10 multi-line patterns
$shown = 0
foreach ($alert in $alerts) {
    if ($shown -ge 5) { break }
    $loc = $alert.most_recent_instance.location
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
    if (-not (Test-Path $absPath)) { continue }
    $lines = [System.IO.File]::ReadAllLines($absPath)
    $catchLn = $loc.start_line - 1
    # Check if multi-line
    $catchLine = $lines[$catchLn].Trim()
    if ($catchLine -match '^catch.*\{.*\}') { continue } # single line
    $shown++
    Write-Host "--- multi-line in $($loc.path.Split('/')[-1]) L$($loc.start_line) ---"
    $startL = [Math]::Max(0, $catchLn-1); $endL = [Math]::Min($lines.Count-1, $catchLn+5)
    $startL..$endL | ForEach-Object { Write-Host "  L$($_+1): $($lines[$_])" }
}
