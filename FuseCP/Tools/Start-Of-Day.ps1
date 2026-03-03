param(
    [switch]$SkipEnvironmentCheck,
    [switch]$SkipSolutionSyncCheck,
    [switch]$StartWebsites
)

$ErrorActionPreference = "Stop"

function Test-IsAdministrator {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Ensure-ElevatedSession {
    if (Test-IsAdministrator) {
        return
    }

    if ($env:FUSECP_START_OF_DAY_ELEVATED -eq "1") {
        return
    }

    $args = @(
        "-NoProfile",
        "-ExecutionPolicy", "Bypass",
        "-File", $PSCommandPath
    )

    if ($SkipEnvironmentCheck) { $args += "-SkipEnvironmentCheck" }
    if ($SkipSolutionSyncCheck) { $args += "-SkipSolutionSyncCheck" }
    if ($StartWebsites) { $args += "-StartWebsites" }

    Write-Host "Current shell is not elevated. Requesting Administrator permissions for start-of-day tasks..." -ForegroundColor Yellow

    try {
        $childProcess = Start-Process -FilePath "pwsh" -ArgumentList $args -Verb RunAs -Wait -PassThru -WorkingDirectory (Get-Location) -Environment @{ FUSECP_START_OF_DAY_ELEVATED = "1" }
        exit $childProcess.ExitCode
    }
    catch {
        throw "Unable to start elevated shell. Please approve UAC prompt or run an Administrator shell."
    }
}

function Ensure-SqlExpressRunning {
    $sqlService = Get-Service -Name "MSSQL`$SQLEXPRESS" -ErrorAction SilentlyContinue
    if ($null -eq $sqlService) {
        Write-Host "SQLExpress service not found (MSSQL`$SQLEXPRESS)." -ForegroundColor DarkYellow
        return
    }

    if ($sqlService.Status -eq "Running") {
        return
    }

    Write-Host "Starting SQLExpress service (MSSQL`$SQLEXPRESS)..." -ForegroundColor Cyan
    Start-Service -Name "MSSQL`$SQLEXPRESS"
}

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..\..")
$checkEnvironmentScript = Join-Path $PSScriptRoot "check-test-environment.ps1"
$checkSolutionSyncScript = Join-Path $PSScriptRoot "check-sln-scope-sync.ps1"
$startWebsiteScript = Join-Path $PSScriptRoot "StartWebsite.ps1"

if (-not (Test-Path $checkEnvironmentScript)) {
    throw "Required script not found: $checkEnvironmentScript"
}

if (-not (Test-Path $checkSolutionSyncScript)) {
    throw "Required script not found: $checkSolutionSyncScript"
}

if ($StartWebsites -and -not (Test-Path $startWebsiteScript)) {
    throw "Required script not found: $startWebsiteScript"
}

Set-Location $repoRoot

Ensure-ElevatedSession

if (-not $SkipEnvironmentCheck) {
    Ensure-SqlExpressRunning
}

if (-not $SkipEnvironmentCheck) {
    Write-Host "Running environment check (Profile: Full)..." -ForegroundColor Cyan
    & pwsh -NoProfile -ExecutionPolicy Bypass -File $checkEnvironmentScript -Profile Full
    if ($LASTEXITCODE -ne 0) {
        throw "Environment check failed. Resolve prerequisites before continuing."
    }
}
else {
    Write-Host "Skipping environment check." -ForegroundColor DarkYellow
}

if (-not $SkipSolutionSyncCheck) {
    Write-Host "Running solution sync check..." -ForegroundColor Cyan
    & pwsh -NoProfile -ExecutionPolicy Bypass -File $checkSolutionSyncScript
    if ($LASTEXITCODE -ne 0) {
        throw "Solution sync check failed. Align FuseCP.sln with scope solutions before continuing."
    }
}
else {
    Write-Host "Skipping solution sync check." -ForegroundColor DarkYellow
}

if ($StartWebsites) {
    Write-Host "Starting local websites..." -ForegroundColor Cyan
    & pwsh -NoProfile -ExecutionPolicy Bypass -File $startWebsiteScript
}

Write-Host "Start-of-day routine completed." -ForegroundColor Green
