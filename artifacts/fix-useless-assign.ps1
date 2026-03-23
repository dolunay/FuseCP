$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json
$alerts = $j | Where-Object { $_.rule.id -eq "cs/useless-assignment-to-local" }
Write-Host "Total alerts: $($alerts.Count)"

# Only target standalone null/false/true/0/"" assignments: the entire line is just "varName = const;"
$byFile = @{}
foreach ($alert in $alerts) {
    $loc = $alert.most_recent_instance.location
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
    if (-not (Test-Path $absPath)) { continue }
    $lines = [System.IO.File]::ReadAllLines($absPath)
    $ln = $loc.start_line - 1
    if ($ln -ge $lines.Count) { continue }
    $sc = [Math]::Max(0,$loc.start_column-1)
    $ec = [Math]::Min($loc.end_column-1, $lines[$ln].Length)
    if ($sc -ge $ec) { continue }
    $span = $lines[$ln].Substring($sc, $ec-$sc)
    $msg = $alert.most_recent_instance.message.text
    $varName = if ($msg -match "assignment to (\w+) is useless") { $Matches[1] } else { continue }
    $reNull = '^' + [regex]::Escape($varName) + '\s*=\s*(null|false|true|0|""|-1)\s*$'
    if ($span -notmatch $reNull) { continue }
    
    # Check the full trimmed line matches the standalone assignment pattern
    $fullLine = $lines[$ln].Trim()
    $fullRe = '^' + [regex]::Escape($varName) + '\s*=\s*(null|false|true|0|""|-1)\s*;?\s*(//.*)?$'
    if ($fullLine -notmatch $fullRe) { continue }
    
    # Group by file
    if (-not $byFile.ContainsKey($absPath)) { $byFile[$absPath] = [System.Collections.Generic.List[int]]::new() }
    $byFile[$absPath].Add($ln)
}

Write-Host "Lines to remove: $($byFile.Values | ForEach-Object { $_.Count } | Measure-Object -Sum | Select-Object -ExpandProperty Sum)"

$totalFixed = 0
foreach ($kvp in $byFile.GetEnumerator()) {
    $absPath = $kvp.Key
    $linesToRemove = $kvp.Value | Sort-Object -Descending -Unique
    $lines = [System.Collections.Generic.List[string]]([System.IO.File]::ReadAllLines($absPath))
    foreach ($ln in $linesToRemove) {
        if ($ln -lt $lines.Count) {
            $lines.RemoveAt($ln)
            $totalFixed++
        }
    }
    [System.IO.File]::WriteAllLines($absPath, $lines, [System.Text.UTF8Encoding]::new($false))
    Write-Host "Removed $($kvp.Value.Count) lines in $($absPath.Split('\')[-1])"
}
Write-Host "Total: $totalFixed"
