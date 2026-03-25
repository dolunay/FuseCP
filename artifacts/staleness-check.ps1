$j = Get-Content "C:\git\FuseCPDevOPS-FuseCP\artifacts\codeql-open-alerts.json" | ConvertFrom-Json

$rules = @('cs/path-combine','cs/useless-assignment-to-local','cs/catch-of-all-exceptions',
           'cs/local-not-disposed','cs/dereferenced-value-may-be-null',
           'js/unused-local-variable','cs/missed-ternary-operator',
           'cs/linq/missed-where','cs/linq/missed-select',
           'cs/nested-if-statements','cs/local-shadows-member',
           'cs/class-name-matches-base-class','cs/constant-condition')

foreach ($rule in $rules) {
    $alerts = $j | Where-Object { $_.rule.id -eq $rule }
    if ($alerts.Count -eq 0) { continue }
    
    $missing = 0; $present = 0
    foreach ($alert in ($alerts | Select-Object -First 50)) {
        $loc = $alert.most_recent_instance.location
        $absPath = "C:\git\FuseCPDevOPS-FuseCP\" + $loc.path.Replace('/','\')
        if (-not (Test-Path $absPath)) { $missing++; continue }
        $lines = [System.IO.File]::ReadAllLines($absPath)
        if ($loc.start_line - 1 -ge $lines.Count) { $missing++; continue }
        $present++
    }
    Write-Host "$rule`: total=$($alerts.Count) sample50_present=$present missing_or_past_end=$missing"
}
