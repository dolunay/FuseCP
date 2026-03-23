$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json
$alerts = $j | Where-Object { $_.rule.id -eq "cs/empty-catch-block" }

# Get all distinct single-line catch patterns
$singleLinePatterns = @{}
foreach ($alert in $alerts) {
    $loc = $alert.most_recent_instance.location
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
    if (-not (Test-Path $absPath)) { continue }
    $lines = [System.IO.File]::ReadAllLines($absPath)
    $catchLn = $loc.start_line - 1
    $catchLine = $lines[$catchLn].Trim()
    # Check for single-line catch { }
    if ($catchLine -match '\{.*\}') {
        $cur = $singleLinePatterns[$catchLine]; if ($cur -eq $null) { $cur = 0 }; $singleLinePatterns[$catchLine] = $cur + 1
    }
}

Write-Host "Single-line patterns:"
$singleLinePatterns.GetEnumerator() | Sort-Object Value -Descending | ForEach-Object { Write-Host "  [$($_.Key)]: $($_.Value)" }
