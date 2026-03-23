$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json
$alerts = $j | Where-Object { $_.rule.id -eq "cs/local-not-disposed" }

# Safe types including factory-created ones
$safeTypes = @('MD5','Aes','SHA1','RandomNumberGenerator','PasswordDeriveBytes',
               'CryptoStream','StringWriter','StringReader','XmlNodeReader',
               'XmlTextWriter','XmlTextReader','MemoryStream','CancellationTokenSource',
               'SolidBrush','SKImage','Ping','SemaphoreSlim','GZipStream',
               'StringContent','HttpRequestMessage','EventLog','SecureString',
               'HashAlgorithm','SymmetricAlgorithm')

$byFile = $alerts | Where-Object {
    $msg = $_.most_recent_instance.message.text
    $typeName = if ($msg -match "Disposable '(.+)' is created") { $Matches[1] } else { "" }
    $safeTypes -contains $typeName
} | Group-Object { $_.most_recent_instance.location.path }

$totalFixed = 0

foreach ($group in ($byFile | Sort-Object Name)) {
    $relPath = $group.Name
    $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $relPath.Replace('/', '\')
    if (-not (Test-Path $absPath)) { continue }
    $lines = [System.IO.File]::ReadAllLines($absPath)
    $changed = $false

    $sorted = $group.Group | Sort-Object { $_.most_recent_instance.location.start_line } -Descending

    foreach ($alert in $sorted) {
        $loc = $alert.most_recent_instance.location
        $ln = $loc.start_line - 1
        if ($ln -lt 0 -or $ln -ge $lines.Count) { continue }
        $line = $lines[$ln]
        $trimmed = $line.TrimStart()
        $indent = $line.Length - $trimmed.Length
        $indentStr = $line.Substring(0, $indent)

        # Already has using
        if ($trimmed -match '^using ') { continue }
        
        # Must be a variable declaration of the safe type (either var or explicit type)
        # Pattern 1: var x = new T(
        # Pattern 2: var x = T.Create(
        # Pattern 3: T x = new T(
        # Pattern 4: T x = T.Create(
        if ($trimmed -match '^(var\s+\w+|[A-Za-z][\w<>\[\]]+\s+\w+)\s*=\s*(new\s+|[A-Za-z][\w.]+\.Create\b)') {
            $lines[$ln] = $indentStr + "using " + $trimmed
            $changed = $true; $totalFixed++
        }
    }
    
    if ($changed) {
        [System.IO.File]::WriteAllLines($absPath, $lines, [System.Text.UTF8Encoding]::new($false))
        Write-Host "Fixed updates in $($relPath.Split('/')[-1])"
    }
}
Write-Host "Additional fixed: $totalFixed"
