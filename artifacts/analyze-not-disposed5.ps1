$a = Get-Content "artifacts\codeql-open-alerts.json" | ConvertFrom-Json
$r = $a | Where-Object { $_.rule.id -eq "cs/local-not-disposed" }

# Find ones NOT already using 'using'
$realRemaining = [System.Collections.Generic.List[object]]::new()
foreach ($item in $r) {
    $loc = $item.most_recent_instance.location
    $absPath = Join-Path "C:\git\FuseCPDevOPS-FuseCP" $loc.path
    if (-not (Test-Path $absPath)) { continue }
    $lines = Get-Content $absPath
    $ln = $loc.start_line - 1
    if ($ln -lt 0 -or $ln -ge $lines.Count) { continue }
    $lineText = $lines[$ln].Trim()
    # Skip already-using or already-disposed
    if ($lineText -match '^\s*using\s') { continue }
    if ($lineText -match '^\s*(//|#)') { continue }
    # Skip if line doesn't look like a var declaration
    if ($lineText -notmatch '\bnew\s+\w') { continue }
    
    $msg = $item.most_recent_instance.message.text
    $typeName = if ($msg -match "Disposable '([^']+)'") { $Matches[1] } else { "unknown" }
    
    $realRemaining.Add([pscustomobject]@{
        File = $loc.path
        Line = $loc.start_line
        Type = $typeName
        Code = $lineText
    })
}

Write-Host "Genuinely unfixed: $($realRemaining.Count)"
$realRemaining | Group-Object Type | Sort-Object Count -Descending | ForEach-Object { Write-Host "$($_.Count) $($_.Name)" }
Write-Host ""
Write-Host "Samples:"
$realRemaining | Select-Object -First 15 | ForEach-Object { Write-Host "  L$($_.Line) [$($_.Type)] $($_.Code.Substring(0, [Math]::Min(80, $_.Code.Length)))" }
