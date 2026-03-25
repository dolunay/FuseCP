$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json
$alerts = $j | Where-Object { $_.rule.id -eq "cs/missed-readonly-modifier" }
Write-Host "Alerts: $($alerts.Count)"
$byFile = $alerts | Group-Object { $_.most_recent_instance.location.path }
$totalFixed = 0
$filesEdited = [System.Collections.Generic.List[string]]::new()
foreach ($group in $byFile) {
    $relPath = $group.Name
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $relPath.Replace('/', '\')
    if (-not (Test-Path $absPath)) { Write-Host "MISSING: $relPath"; continue }
    $lines = [System.IO.File]::ReadAllLines($absPath)
    $changed = $false
    foreach ($alert in $group.Group) {
        $ln = $alert.most_recent_instance.location.start_line - 1
        if ($ln -lt 0 -or $ln -ge $lines.Count) { continue }
        $origLine = $lines[$ln]
        if ($origLine -match '\breadonly\b') { continue }
        $newLine = $origLine
        # Pattern 1: access modifier [static/virtual/etc] TYPE
        $newLine = $origLine -replace '^(\s*(?:private|protected|public|internal)(?:\s+static|\s+virtual|\s+override|\s+abstract|\s+new|\s+extern)*\s+)(?!readonly\b)', '$1readonly '
        # Pattern 2: standalone static (no access modifier)
        if ($newLine -eq $origLine) { $newLine = $origLine -replace '^(\s*static(?:\s+virtual|\s+override|\s+abstract|\s+new|\s+extern)*\s+)(?!readonly\b)', '$1readonly ' }
        # Pattern 3: field with no access modifier and no static (just TYPE name = ...)
        # Only apply if line looks like a field declaration: indent + Type(not keyword) + space + name
        if ($newLine -eq $origLine) {
            $newLine = $origLine -replace '^(\s+)(?!readonly\b|if\b|for\b|while\b|return\b|var\b|using\b|throw\b|//|/\*|\[)(?=[A-Za-z_])', '$1readonly '
        }
        if ($newLine -ne $origLine) {
            $lines[$ln] = $newLine; $changed = $true; $totalFixed++
        } else { Write-Host "NOMATCH L$($ln+1): [$($origLine.Trim())]" }
    }
    if ($changed) {
        [System.IO.File]::WriteAllLines($absPath, $lines, [System.Text.UTF8Encoding]::new($false))
        $filesEdited.Add($relPath.Split('/')[-1]) | Out-Null
        Write-Host "Fixed $($group.Group.Count) in $($relPath.Split('/')[-1])"
    }
}
Write-Host "Total: $totalFixed in $($filesEdited.Count) files"
