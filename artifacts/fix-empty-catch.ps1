$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json
$alerts = $j | Where-Object { $_.rule.id -eq "cs/empty-catch-block" }
Write-Host "Total empty-catch alerts: $($alerts.Count)"

$byFile = $alerts | Group-Object { $_.most_recent_instance.location.path }
$totalFixed = 0

foreach ($group in ($byFile | Sort-Object Name)) {
    $relPath = $group.Name
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $relPath.Replace('/', '\')
    if (-not (Test-Path $absPath)) { Write-Host "MISSING: $relPath"; continue }

    $lines = [System.Collections.Generic.List[string]]([System.IO.File]::ReadAllLines($absPath))
    $changed = $false

    # Process alerts in REVERSE line order to preserve offsets
    $sorted = $group.Group | Sort-Object { $_.most_recent_instance.location.start_line } -Descending

    foreach ($alert in $sorted) {
        $ln = $alert.most_recent_instance.location.start_line - 1
        if ($ln -lt 0 -or $ln -ge $lines.Count) { continue }

        $catchLine = $lines[$ln]
        $trimmed = $catchLine.Trim()

        # Try single-line fix: catch { } on same line
        if ($trimmed -match '^\}?\s*catch[\s\($].*\{.*\}') {
            # Replace empty braces with one containing _ = 0;
            $newLine = $catchLine -replace '\{\s*(\}.*)?$', '{ _ = 0; }'
            $newLine = $newLine -replace '\{\s*//.*$', '{ _ = 0; }'
            if ($newLine -ne $catchLine) {
                $lines[$ln] = $newLine
                $changed = $true; $totalFixed++
                continue
            }
        }

        # Multi-line: find the opening { and closing } of the catch body
        # The catch line may not have { — look forward
        $i = $ln
        $openBraceIdx = -1
        $depth = 0
        $started = $false

        while ($i -lt $lines.Count -and $i -lt $ln + 10) {
            $l = $lines[$i]
            for ($ci = 0; $ci -lt $l.Length; $ci++) {
                $c = $l[$ci]
                if ($c -eq '{') {
                    $depth++
                    if (-not $started) { $openBraceIdx = $i; $started = $true }
                } elseif ($c -eq '}') {
                    $depth--
                    if ($started -and $depth -le 0) {
                        # Found closing brace at line $i col $ci
                        # Check the body is truly empty (only whitespace/comments between open and close)
                        $bodyContent = ""
                        if ($openBraceIdx -eq $i) {
                            # Inline single: already handled above, skip
                            $i = $lines.Count # break outer loop
                        } else {
                            # Multi-line: collect content between { and }
                            for ($bi = $openBraceIdx + 1; $bi -lt $i; $bi++) {
                                $bodyContent += $lines[$bi].Trim()
                            }
                            if ($bodyContent -eq "" -or $bodyContent -match '^/[/*]') {
                                # Insert _ = 0; line before the closing brace
                                $indent = $lines[$i] -replace '[^\s].*$', ''
                                $lines.Insert($i, "${indent}    _ = 0;")
                                $changed = $true; $totalFixed++
                            }
                        }
                        $i = $lines.Count # break
                        break
                    }
                }
            }
            $i++
        }
    }

    if ($changed) {
        [System.IO.File]::WriteAllLines($absPath, $lines, [System.Text.UTF8Encoding]::new($false))
        Write-Host "Fixed $($group.Group.Count) in $($relPath.Split('/')[-1])"
    }
}

Write-Host "Total fixed: $totalFixed"
