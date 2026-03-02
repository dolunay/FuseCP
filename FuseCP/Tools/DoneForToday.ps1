param(
    [switch]$SkipShutdown
)

$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..\..")
$notesDir = Join-Path $repoRoot "artifacts\session-notes"
New-Item -ItemType Directory -Force -Path $notesDir | Out-Null

$timestamp = Get-Date -Format "yyyy-MM-dd_HHmm"
$notesPath = Join-Path $notesDir ("{0}.md" -f $timestamp)

$shutdownResult = "Skipped"
if (-not $SkipShutdown) {
    try {
        & (Join-Path $PSScriptRoot "StopWebsite.ps1") -StopSqlExpress -ShutdownWsl
        $shutdownResult = "Completed"
    }
    catch {
        $shutdownResult = "Completed with warning: $($_.Exception.Message)"
    }
}

$branch = (& git -C $repoRoot rev-parse --abbrev-ref HEAD 2>$null | Out-String).Trim()
if ([string]::IsNullOrWhiteSpace($branch)) {
    $branch = "unknown"
}

$changedFiles = (& git -C $repoRoot status --short 2>$null | Out-String).Trim()
if ([string]::IsNullOrWhiteSpace($changedFiles)) {
    $changedFiles = "(no local changes)"
}

$serviceNames = @("MSSQL$SQLEXPRESS", "W3SVC")
$serviceLines = @()
foreach ($serviceName in $serviceNames) {
    $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
    if ($null -eq $service) {
        $serviceLines += "- ${serviceName}: not found"
        continue
    }

    $serviceConfig = Get-CimInstance Win32_Service -Filter "Name='$serviceName'"
    $serviceLines += "- ${serviceName}: status=$($service.Status), startup=$($serviceConfig.StartMode)"
}

$wslStatus = (& wsl --list --verbose 2>$null | Out-String).Trim()
if ([string]::IsNullOrWhiteSpace($wslStatus)) {
    $wslStatus = "(WSL status unavailable)"
}

$content = @"
# FuseCP Session Handoff ($timestamp)

## Summary
- Branch: $branch
- Done-for-today shutdown: $shutdownResult

## Local Changes
```
$changedFiles
```

## Service State
$($serviceLines -join [Environment]::NewLine)

## WSL
```
$wslStatus
```

## Next Start Checklist
1. Run start-of-day routine (includes environment + solution sync checks):
    - powershell -NoProfile -ExecutionPolicy Bypass -File "FuseCP/Tools/Start-Of-Day.ps1"
2. Optional: start local test websites in the same routine:
    - powershell -NoProfile -ExecutionPolicy Bypass -File "FuseCP/Tools/Start-Of-Day.ps1" -StartWebsites
3. Continue work from current branch and changed files above.
"@

Set-Content -Path $notesPath -Value $content -Encoding UTF8
Write-Host "Session note written: $notesPath" -ForegroundColor Green