$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json
$alerts = $j | Where-Object { $_.rule.id -eq "cs/nested-if-statements" }
Write-Host "Count: $($alerts.Count)"

$simple = 0; $complex = 0

foreach ($alert in $alerts) {
    $loc = $alert.most_recent_instance.location
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
    if (-not (Test-Path $absPath)) { continue }
    $lines = [System.IO.File]::ReadAllLines($absPath)
    $outerIfLn = $loc.start_line - 1
    if ($outerIfLn -ge $lines.Count) { continue }
    
    $line = $lines[$outerIfLn]
    $trimmed = $line.TrimStart()
    
    # Get the outer if condition
    if (-not ($trimmed -match '^if\s*\(')) { continue }
    
    # Find outer opening brace
    $outerBraceOpen = $outerIfLn
    $depth = 0
    $outerBodyStart = -1; $outerBodyEnd = -1
    $started = $false
    
    for ($i = $outerIfLn; $i -lt [Math]::Min($lines.Count, $outerIfLn+3); $i++) {
        foreach ($c in $lines[$i].ToCharArray()) {
            if ($c -eq '{') { if (-not $started) { $outerBodyStart = $i; $started = $true }; $depth++ }
            elseif ($c -eq '}') { $depth-- }
        }
        if ($started -and $depth -eq 0) { $outerBodyEnd = $i; break }
    }
    
    if ($outerBodyStart -lt 0 -or $outerBodyEnd -lt 0) {
        # Find it over more lines
        for ($i = $outerIfLn; $i -lt [Math]::Min($lines.Count, $outerIfLn+100); $i++) {
            foreach ($c in $lines[$i].ToCharArray()) {
                if ($c -eq '{') { if (-not $started) { $outerBodyStart = $i; $started = $true }; $depth++ }
                elseif ($c -eq '}') { $depth-- }
            }
            if ($started -and $depth -eq 0) { $outerBodyEnd = $i; break }
        }
    }
    
    if ($outerBodyStart -lt 0 -or $outerBodyEnd -lt 0) { $complex++; continue }
    
    # Collect lines in the outer body (between { and })
    $innerLines = @()
    for ($i = $outerBodyStart+1; $i -lt $outerBodyEnd; $i++) {
        $t = $lines[$i].Trim()
        if ($t -ne "") { $innerLines += $t }
    }
    
    # Count non-empty non-comment lines
    $codeLines = $innerLines | Where-Object { $_ -notmatch '^//' -and $_ -ne "" }
    
    # Check if the first line is an if statement
    $firstCodeLine = $codeLines | Select-Object -First 1
    
    if ($firstCodeLine -match '^if\s*\(' -and $codeLines.Count -ge 1) {
        # Might be simple
        $maxBody = $lines[$outerBodyEnd].Trim()
        $hasElse = $false
        if ($outerBodyEnd + 1 -lt $lines.Count) {
            $nextLine = $lines[$outerBodyEnd + 1].Trim()
            if ($nextLine -match '^else') { $hasElse = $true }
        }
        if (-not $hasElse) { $simple++ } else { $complex++ }
    } else {
        $complex++
    }
}

Write-Host "Simple (no else, inner starts with if): $simple"
Write-Host "Complex: $complex"
