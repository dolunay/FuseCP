$a = Get-Content "artifacts\codeql-open-alerts.json" | ConvertFrom-Json
$r = $a | Where-Object { $_.rule.id -eq "cs/local-not-disposed" -and $_.most_recent_instance.message.text -like "*DirectoryEntry*" }
Write-Host "DirectoryEntry total: $($r.Count)"
$r | Select-Object -First 8 | ForEach-Object {
    $loc = $_.most_recent_instance.location
    $absPath = Join-Path "C:\git\FuseCPDevOPS-FuseCP" $loc.path
    if (-not (Test-Path $absPath)) { return }
    $lines = Get-Content $absPath
    $ln = $loc.start_line - 1
    Write-Host "---"
    Write-Host "$($loc.path):L$($loc.start_line)"
    if ($ln -ge 0 -and $ln -lt $lines.Count) {
        $end = [Math]::Min($ln+4, $lines.Count-1)
        for ($i = $ln; $i -le $end; $i++) { Write-Host "$($i+1): $($lines[$i])" }
    }
}
