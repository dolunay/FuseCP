$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json
$alerts = $j | Where-Object { $_.rule.id -eq "cs/local-not-disposed" }
Write-Host "Total: $($alerts.Count)"

# Types that are safe to wrap with 'using var' (crypto, imaging, text, cancellation)
$safeTypes = @('MD5','Aes','SHA1','RandomNumberGenerator','PasswordDeriveBytes',
               'CryptoStream','StringWriter','StringReader','XmlNodeReader',
               'XmlTextWriter','XmlTextReader','MemoryStream','CancellationTokenSource',
               'SolidBrush','SKImage','Ping','SemaphoreSlim','GZipStream',
               'StringContent','HttpRequestMessage','EventLog','SecureString')

$byFile = $alerts | Where-Object {
    $msg = $_.most_recent_instance.message.text
    $typeName = if ($msg -match "Disposable '(.+)' is created") { $Matches[1] } else { "" }
    $safeTypes -contains $typeName
} | Group-Object { $_.most_recent_instance.location.path }

Write-Host "Targeting $($byFile.Count) files with safe types"

$totalFixed = 0

foreach ($group in ($byFile | Sort-Object Name)) {
    $relPath = $group.Name
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $relPath.Replace('/', '\')
    if (-not (Test-Path $absPath)) { Write-Host "MISSING: $relPath"; continue }

    $lines = [System.IO.File]::ReadAllLines($absPath)
    $changed = $false

    # Process alerts in REVERSE line order
    $sorted = $group.Group | Sort-Object { $_.most_recent_instance.location.start_line } -Descending

    foreach ($alert in $sorted) {
        $loc = $alert.most_recent_instance.location
        $ln = $loc.start_line - 1
        if ($ln -lt 0 -or $ln -ge $lines.Count) { continue }
        
        $line = $lines[$ln]
        $trimmed = $line.TrimStart()
        
        # Already has using
        if ($trimmed -match '^using ') { continue }
        
        # Pattern: var x = new T(...) OR Type x = new T(...)
        # The span points to new T() constructor call
        $sc = [Math]::Max(0, $loc.start_column - 1)
        $ec = [Math]::Min($loc.end_column - 1, $line.Length)
        if ($sc -ge $line.Length) { continue }
        
        $span = if ($sc -lt $ec) { $line.Substring($sc, $ec-$sc) } else { "" }
        
        # Verify span starts with 'new '
        if (-not $span.StartsWith("new ")) {
            # Might be on a different segment - check full line
            Write-Host "SKIP (no new): [$($trimmed.Substring(0,[Math]::Min(60,$trimmed.Length)))] in $($relPath.Split('/')[-1]):$($loc.start_line)"
            continue
        }
        
        # Add 'using ' before 'var ' or before the type name in declaration
        # var x = new T(...) → using var x = new T(...)
        # T x = new T(...) → using T x = new T(...)
        $indent = $line.Length - $line.TrimStart().Length
        $indentStr = $line.Substring(0, $indent)
        
        if ($trimmed -match '^(var|[A-Za-z][\w<>?,\s]+)\s+\w+\s*=\s*new ') {
            $lines[$ln] = $indentStr + "using " + $trimmed
            $changed = $true; $totalFixed++
        } else {
            Write-Host "SKIP (no match): [$($trimmed.Substring(0,[Math]::Min(60,$trimmed.Length)))] in $($relPath.Split('/')[-1]):$($loc.start_line)"
        }
    }
    
    if ($changed) {
        [System.IO.File]::WriteAllLines($absPath, $lines, [System.Text.UTF8Encoding]::new($false))
        Write-Host "Fixed $($group.Group.Count) in $($relPath.Split('/')[-1])"
    }
}

Write-Host "Total fixed: $totalFixed"
