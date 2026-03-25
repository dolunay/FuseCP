#!/usr/bin/env pwsh
# Fix Exchange2013/2016/2019 useless assignments (clean version)

$repoRoot = "C:\git\FuseCPDevOPS-FuseCP"

$fixes = @(
    "FuseCP\Sources\FuseCP.Providers.HostedSolution.Exchange2019\Exchange2019.cs",
    "FuseCP\Sources\FuseCP.Providers.HostedSolution.Exchange2016\Exchange2016.cs",
    "FuseCP\Sources\FuseCP.Providers.HostedSolution.Exchange2013\Exchange2013.cs"
)

foreach ($filePath in $fixes) {
    $absPath = Join-Path $repoRoot $filePath
    if (-not (Test-Path $absPath)) { Write-Host "NOT FOUND: $($fix.File)"; continue }
    
    $lines = [System.IO.File]::ReadAllLines($absPath)
    $changed = $false
    
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $l = $lines[$i].Trim()
        
        # Pattern 1: currentStep declaration
        if ($l -match '^string currentStep\s*=\s*"([^"]+)"\s*;$') {
            $initVal = $Matches[1]
            # Find the try { opening
            $j = $i + 1
            while ($j -lt $lines.Count -and $lines[$j].Trim() -eq "") { $j++ }
            if ($j -lt $lines.Count -and $lines[$j].Trim() -eq "try") { $j++ }
            while ($j -lt $lines.Count -and ($lines[$j].Trim() -eq "" -or $lines[$j].Trim() -eq "{")) { $j++ }
            if ($j -lt $lines.Count) {
                if ($lines[$j].Trim() -eq "currentStep = `"$initVal`";") {
                    Write-Host "REMOVE redundant: $([System.IO.Path]::GetFileName($absPath)) L$($j+1) [$($lines[$j].Trim())]"
                    $lines[$j] = $null
                    $changed = $true
                }
            }
        }
        
        # Pattern 2: PSObject mailbox = result[0]; unused
        if ($l -match '^PSObject mailbox\s*=\s*result\[0\]\s*;$') {
            # Use case-sensitive check to avoid "Set-Mailbox" strings matching
            $usedAfter = $false
            for ($k = $i + 1; $k -lt [Math]::Min($i + 30, $lines.Count); $k++) {
                if ($lines[$k] -cmatch '\bmailbox\b') { $usedAfter = $true; break }
            }
            if (-not $usedAfter) {
                Write-Host "REMOVE unused: $([System.IO.Path]::GetFileName($absPath)) L$($i+1) [$l]"
                $lines[$i] = $null
                $changed = $true
            }
        }
    }
    
    if ($changed) {
        $filtered = $lines | Where-Object { $_ -ne $null }
        [System.IO.File]::WriteAllLines($absPath, $filtered, [System.Text.UTF8Encoding]::new($false))
        Write-Host "SAVED: $([System.IO.Path]::GetFileName($absPath))"
    }
}
Write-Host "Done"
