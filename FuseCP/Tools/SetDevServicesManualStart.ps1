param(
    [switch]$StopNow
)

$ErrorActionPreference = "Stop"

$serviceNames = @(
    'MSSQL$SQLEXPRESS',
    'W3SVC'
)

foreach ($serviceName in $serviceNames) {
    $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
    if ($null -eq $service) {
        Write-Host "Service not found: $serviceName" -ForegroundColor DarkYellow
        continue
    }

    Set-Service -Name $serviceName -StartupType Manual
    Write-Host "Set startup type to Manual: $serviceName" -ForegroundColor Yellow

    if ($StopNow -and $service.Status -eq "Running") {
        Stop-Service -Name $serviceName -Force
        Write-Host "Stopped service: $serviceName" -ForegroundColor Yellow
    }
}

if ($StopNow) {
    $wsl = Get-Command wsl -ErrorAction SilentlyContinue
    if ($null -ne $wsl) {
        & wsl --shutdown
        Write-Host "WSL has been shut down." -ForegroundColor Yellow
    }
}

Write-Host "Done." -ForegroundColor Green
