param(
    [switch]$StopSqlExpress,
    [switch]$ShutdownWsl
)

$ErrorActionPreference = "Stop"

function Test-IsAdministrator {
    try {
        $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
        $principal = New-Object Security.Principal.WindowsPrincipal($identity)
        return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    }
    catch {
        return $false
    }
}

if (-not (Test-IsAdministrator)) {
    Write-Host "Skipping IIS website stop (not running as Administrator)." -ForegroundColor DarkYellow
}
else {
    try {
        Import-Module WebAdministration -ErrorAction Stop

        $siteNames = @(
            "FuseCP Portal",
            "FuseCP Enterprise Server",
            "FuseCP Server"
        )

        foreach ($siteName in $siteNames) {
            $sitePath = "IIS:\Sites\$siteName"
            if (Test-Path $sitePath) {
                $siteState = (Get-Website -Name $siteName).State
                if ($siteState -ne "Stopped") {
                    Stop-Website -Name $siteName
                    Write-Host "Stopped IIS website: $siteName" -ForegroundColor Yellow
                }
                else {
                    Write-Host "IIS website already stopped: $siteName" -ForegroundColor DarkYellow
                }
            }
            else {
                Write-Host "IIS website not found: $siteName" -ForegroundColor DarkYellow
            }
        }
    }
    catch {
        Write-Host "Skipping IIS website stop (WebAdministration unavailable)." -ForegroundColor DarkYellow
        Write-Host $_.Exception.Message -ForegroundColor DarkYellow
    }
}

if ($StopSqlExpress) {
    $sqlService = Get-Service -Name "MSSQL`$SQLEXPRESS" -ErrorAction SilentlyContinue
    if ($null -eq $sqlService) {
        Write-Host "SQLExpress service not found (MSSQL`$SQLEXPRESS)." -ForegroundColor DarkYellow
    }
    elseif ($sqlService.Status -eq "Running") {
        Stop-Service -Name "MSSQL`$SQLEXPRESS" -Force
        Write-Host "Stopped SQLExpress service: MSSQL`$SQLEXPRESS" -ForegroundColor Yellow
    }
    else {
        Write-Host "SQLExpress service already stopped." -ForegroundColor DarkYellow
    }
}

if ($ShutdownWsl) {
    $wsl = Get-Command wsl -ErrorAction SilentlyContinue
    if ($null -eq $wsl) {
        Write-Host "WSL command not found." -ForegroundColor DarkYellow
    }
    else {
        & wsl --shutdown
        Write-Host "WSL has been shut down." -ForegroundColor Yellow
    }
}

Write-Host "Done." -ForegroundColor Green