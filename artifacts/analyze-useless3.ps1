$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json
$alerts = $j | Where-Object { $_.rule.id -eq "cs/useless-assignment-to-local" }
Write-Host "Total: $($alerts.Count)"

# Focus on standalone null assignments: "x = null;"
# Show context for these
$nullAssigns = @(); $otherAssigns = @()

foreach ($alert in $alerts) {
    $loc = $alert.most_recent_instance.location
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
    if (-not (Test-Path $absPath)) { continue }
    $lines = [System.IO.File]::ReadAllLines($absPath)
    $ln = $loc.start_line - 1
    if ($ln -ge $lines.Count) { continue }
    $sc = [Math]::Max(0,$loc.start_column-1); $ec = [Math]::Min($loc.end_column-1, $lines[$ln].Length)
    if ($sc -ge $ec) { continue }
    $span = $lines[$ln].Substring($sc, $ec-$sc)
    $msg = $alert.most_recent_instance.message.text
    $varName = if ($msg -match "assignment to (\w+) is useless") { $Matches[1] } else { "?" }
    
    # Check if this is: varName = null (or false/0/empty)
    $reNull = '^' + [regex]::Escape($varName) + '\s*=\s*(null|false|true|0|"")\s*$'
    if ($span -match $reNull) {
        $nullAssigns += [pscustomobject]@{ Alert=$alert; Span=$span; VarName=$varName; File=$loc.path.Split('/')[-1]; Line=$loc.start_line }
    } else {
        $otherAssigns += [pscustomobject]@{ Span=$span; VarName=$varName; File=$loc.path.Split('/')[-1]; Line=$loc.start_line }
    }
}

Write-Host "Null/bool/zero standalone assigns: $($nullAssigns.Count)"
Write-Host "Other assigns: $($otherAssigns.Count)"

Write-Host ""
Write-Host "=== Sample null assigns ==="
$nullAssigns | Select-Object -First 10 | ForEach-Object {
    Write-Host "  [$($_.Span)] in $($_.File):$($_.Line)"
    # Show context
    $loc = $_.Alert.most_recent_instance.location
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
    $lines = [System.IO.File]::ReadAllLines($absPath)
    $ln = $loc.start_line - 1
    $startL = [Math]::Max(0,$ln-1); $endL = [Math]::Min($lines.Count-1,$ln+2)
    $startL..$endL | ForEach-Object { Write-Host "    L$($_+1): $($lines[$_].Trim())" }
}

Write-Host ""
Write-Host "=== Sample other assigns ==="
$otherAssigns | Select-Object -First 10 | ForEach-Object {
    Write-Host "  [$($_.Span)] in $($_.File):$($_.Line)"
}
