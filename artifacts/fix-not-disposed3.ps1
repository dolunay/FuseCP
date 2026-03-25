$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json
$alerts = $j | Where-Object { $_.rule.id -eq "cs/local-not-disposed" }
Write-Host "Total: $($alerts.Count)"

# Extended safe types - adding DB, AD, WMI types that are typically local
$safeTypes = @('SqlCommand','MySqlCommand','MySqlConnection','MySqlDataAdapter','SqlDataAdapter','OleDbCommand',
               'DirectoryEntry','DirectorySearcher','PrincipalContext',
               'ManagementObjectSearcher','ManagementClass','ManagementObject','ManagementEventWatcher',
               'XmlNodeReader','XmlTextWriter','XmlTextReader','RunspaceInvoke',
               'X509Store','DataView','DataSet',
               'StreamReader','StreamWriter','FileStream',
               'ServiceLoader','MimeMessage','HttpClientHandler',
               'PasswordAuthenticationMethod','PrivateKeyFile','PrivateKeyAuthenticationMethod',
               'ServerManager','CimMethodParametersCollection')

$byFile = $alerts | Where-Object {
    $msg = $_.most_recent_instance.message.text
    $typeName = if ($msg -match "Disposable '(.+)' is created") { $Matches[1] } else { "" }
    $safeTypes -contains $typeName
} | Group-Object { $_.most_recent_instance.location.path }

Write-Host "Targeting $($byFile.Count) files"
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
        
        # Must be a variable declaration
        if ($trimmed -match '^(var\s+\w+|[A-Za-z][\w<>\[\]]+\s+\w+)\s*=\s*(new\s+|[A-Za-z][\w.]+\.(?:Create|Open|Get)\b)') {
            $lines[$ln] = $indentStr + "using " + $trimmed
            $changed = $true; $totalFixed++
        } else {
            # Check if it's a multi-line new expression (continuation on next line)
            if ($trimmed -match '^(var\s+\w+|[A-Za-z][\w<>\[\]]+\s+\w+)\s*=\s*new\s*$' -or 
                $trimmed -match '^(var\s+\w+|[A-Za-z][\w<>\[\]]+\s+\w+)\s*=\s*new\s+[A-Za-z]') {
                # Multi-line: type var = new\n  Type(args)
                $lines[$ln] = $indentStr + "using " + $trimmed
                $changed = $true; $totalFixed++
            }
        }
    }
    
    if ($changed) {
        [System.IO.File]::WriteAllLines($absPath, $lines, [System.Text.UTF8Encoding]::new($false))
        Write-Host "Fixed in $($relPath.Split('/')[-1])"
    }
}

Write-Host "Total fixed: $totalFixed"
