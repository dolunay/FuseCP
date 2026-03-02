param(
    [switch]$SkipEnvironmentCheck,
    [switch]$SkipSolutionSyncCheck,
    [switch]$StartWebsites
)

$ErrorActionPreference = "Stop"

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
