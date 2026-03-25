$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json
$alerts = $j | Where-Object { $_.rule.id -eq "cs/inefficient-containskey" }
Write-Host "Total: $($alerts.Count)"

$byFile = $alerts | Group-Object { $_.most_recent_instance.location.path }
$totalFixed = 0

foreach ($group in ($byFile | Sort-Object Name)) {
    $relPath = $group.Name
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $relPath.Replace('/', '\')
    if (-not (Test-Path $absPath)) { Write-Host "MISSING: $relPath"; continue }

    $lines = [System.Collections.Generic.List[string]]([System.IO.File]::ReadAllLines($absPath))
    $changed = $false

    $sorted = $group.Group | Sort-Object { $_.most_recent_instance.location.start_line } -Descending

    foreach ($alert in $sorted) {
        $loc = $alert.most_recent_instance.location
        $ln = $loc.start_line - 1
        if ($ln -lt 0 -or $ln -ge $lines.Count) { continue }

        $line = $lines[$ln]
        $sc = [Math]::Max(0,$loc.start_column-1)
        $ec = [Math]::Min($loc.end_column-1, $line.Length)
        if ($sc -ge $ec) { continue }
        $span = $line.Substring($sc, $ec-$sc)

        # Pattern: dict.ContainsKey(key)
        # Extract: dict expression and key expression
        if ($span -notmatch '^(.+)\.ContainsKey\((.+)\)$') {
            Write-Host "NO-MATCH span: [$span] in $($relPath.Split('/')[-1]):$($loc.start_line)"
            continue
        }
        $dictExpr = $Matches[1]
        $keyExpr = $Matches[2]
        $tempVar = "_ck_$($dictExpr -replace '[^a-zA-Z0-9]','_')"
        # Shorten var name
        $tempVar = "_ckv"

        # Pattern 1: Single-line ternary: ContainsKey(k) ? dict[k] : expr
        $lineText = $line
        # Replace full pattern: dict.ContainsKey(key) ? dict[key] : X
        $ternaryPattern = [regex]::Escape($span) + '\s*\?\s*' + [regex]::Escape($dictExpr) + '\[' + [regex]::Escape($keyExpr) + '\]\s*:' 
        if ($lineText -match ($ternaryPattern)) {
            $afterColon = $lineText -replace ('.*' + [regex]::Escape($span) + '\s*\?\s*' + [regex]::Escape($dictExpr) + '\[' + [regex]::Escape($keyExpr) + '\]\s*:(.*)'), '$1'
            $newSpan = "$dictExpr.TryGetValue($keyExpr, out var $tempVar) ? $tempVar :"
            $newLine = $lineText.Substring(0, $sc) + $newSpan + $afterColon
            $lines[$ln] = $newLine
            $changed = $true; $totalFixed++
            Write-Host "FIXED(ternary): $($relPath.Split('/')[-1]):$($loc.start_line)"
            continue
        }

        # Pattern 2: Multi-line if block
        # if (dict.ContainsKey(key)) { body using dict[key] }
        # Check if line is purely the ContainsKey call (as condition)
        $condTrimmed = $lineText.TrimStart()
        if ($condTrimmed -match ('^(if\s*\((?:!?))' + [regex]::Escape($span) + '(\)\s*(?:\{.*)?)$')) {
            $prefix2 = $Matches[1]  # 'if (!' or 'if ('
            $suffix2 = $Matches[2]  # ') {' or ')' etc
            $inverted = $prefix2 -match '!'
            
            # Build replacement condition
            if ($inverted) {
                $newCond = "if (!$dictExpr.TryGetValue($keyExpr, out var $tempVar)$suffix2"
            } else {
                $newCond = "if ($dictExpr.TryGetValue($keyExpr, out var $tempVar)$suffix2"
            }
            
            # Now replace dict[key] usage in the body (next ~10 lines)
            $indent2 = $lineText.Length - $condTrimmed.Length
            $indexerPattern = [regex]::Escape($dictExpr) + '\[' + [regex]::Escape($keyExpr) + '\]'
            $bodyFixed = 0
            $endIdx = [Math]::Min($lines.Count - 1, $ln + 15)
            for ($bi = $ln + 1; $bi -le $endIdx; $bi++) {
                $bLine = $lines[$bi]
                $bTrimmed = $bLine.TrimStart()
                # Stop at closing brace of the if block (same or less indent)
                if ($bTrimmed -eq "}" -or $bTrimmed -eq "};" -or ($bTrimmed.StartsWith("}") -and $bLine.Length - $bTrimmed.Length -le $indent2)) { break }
                if ($bLine -match $indexerPattern) {
                    $lines[$bi] = $bLine -replace $indexerPattern, $tempVar
                    $bodyFixed++
                }
            }
            
            $lines[$ln] = $newCond
            $changed = $true; $totalFixed++
            Write-Host "FIXED(if/body:$bodyFixed): $($relPath.Split('/')[-1]):$($loc.start_line)"
            continue
        }

        Write-Host "UNHANDLED: [$span] -> [$($condTrimmed.Substring(0,[Math]::Min(80,$condTrimmed.Length)))] in $($relPath.Split('/')[-1]):$($loc.start_line)"
    }

    if ($changed) {
        [System.IO.File]::WriteAllLines($absPath, $lines, [System.Text.UTF8Encoding]::new($false))
    }
}

Write-Host "Total fixed: $totalFixed"
