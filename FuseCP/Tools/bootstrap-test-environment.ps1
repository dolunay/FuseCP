param(
    [switch]$Install,
    [switch]$SkipPwsh,
    [switch]$SkipDotNet,
    [switch]$SkipBuildTools,
    [switch]$SkipSqlOdbc,
    [switch]$InstallWsl,
    [string]$WslDistroId = "Canonical.Ubuntu.2204",
    [switch]$InstallWixToolset,
    [switch]$InstallSqlExpress,
    [switch]$InstallIIS,
    [string]$SqlExpressOverride = "/ENU /Q /IACCEPTSQLSERVERLICENSETERMS",
    [switch]$RunAllProfiles,
    [ValidateSet("Unit", "Integration", "Package", "Full")]
    [string[]]$Profiles = @("Unit", "Package")
)

$ErrorActionPreference = "Stop"

function Write-Step {
    param([string]$Message)
    Write-Host "`n==> $Message" -ForegroundColor Cyan
}

function Test-IsAdministrator {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Test-CommandExists {
    param([string]$CommandName)
    return $null -ne (Get-Command $CommandName -ErrorAction SilentlyContinue)
}

function Test-WixCaTargetsAvailable {
    $candidatePaths = @(
        "C:\Program Files\Microsoft Visual Studio\18\Community\MSBuild\Microsoft\WiX\v3.x\Wix.CA.targets",
        "C:\Program Files\Microsoft Visual Studio\18\Professional\MSBuild\Microsoft\WiX\v3.x\Wix.CA.targets",
        "C:\Program Files\Microsoft Visual Studio\18\Enterprise\MSBuild\Microsoft\WiX\v3.x\Wix.CA.targets",
        "C:\Program Files\Microsoft Visual Studio\18\BuildTools\MSBuild\Microsoft\WiX\v3.x\Wix.CA.targets",
        "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\MSBuild\Microsoft\WiX\v3.x\Wix.CA.targets",
        "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Microsoft\WiX\v3.x\Wix.CA.targets",
        "C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Microsoft\WiX\v3.x\Wix.CA.targets",
        "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Microsoft\WiX\v3.x\Wix.CA.targets"
    )

    foreach ($path in $candidatePaths) {
        if (Test-Path $path) {
            return $true
        }
    }

    return $false
}

function Invoke-WingetInstall {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Id,
        [string]$Name,
        [string]$Override,
        [string]$Locale
    )

    $args = @("install", "--id", $Id, "-e", "--accept-package-agreements", "--accept-source-agreements")
    if (-not [string]::IsNullOrWhiteSpace($Locale)) {
        $args += @("--locale", $Locale)
    }
    if (-not [string]::IsNullOrWhiteSpace($Override)) {
        $args += @("--override", $Override)
    }

    Write-Host "Installing $Name via winget..." -ForegroundColor Yellow
    $wingetOutput = (& winget @args 2>&1 | Out-String)
    $exitCode = $LASTEXITCODE

    $alreadySatisfied = $wingetOutput -match "Found an existing package already installed" -or
        $wingetOutput -match "No newer package versions are available"

    if ($exitCode -ne 0 -and -not $alreadySatisfied) {
        throw "winget install failed for $Name ($Id).`n$wingetOutput"
    }

    if ($alreadySatisfied) {
        Write-Host "$Name is already installed and up to date." -ForegroundColor Green
    }
}

function Install-SqlExpressWithFallback {
    param(
        [string]$OverrideArgs
    )

    Write-Host "Installing SQL Server 2022 Express via winget (forced en-US locale)..." -ForegroundColor Yellow
    $installArgs = @(
        "install",
        "--id", "Microsoft.SQLServer.2022.Express",
        "-e",
        "--locale", "en-US",
        "--accept-package-agreements",
        "--accept-source-agreements"
    )

    if (-not [string]::IsNullOrWhiteSpace($OverrideArgs)) {
        $installArgs += @("--override", $OverrideArgs)
    }

    $installOutput = (& winget @installArgs 2>&1 | Out-String)
    $installExitCode = $LASTEXITCODE

    if ($installExitCode -eq 0) {
        Write-Host "SQL Server 2022 Express installation completed via winget." -ForegroundColor Green
        return
    }

    $languageError = $installOutput -match "not supported" -or
        $installOutput -match "exit code:\s*1009"

    if (-not $languageError) {
        throw "winget install failed for SQL Server 2022 Express (Microsoft.SQLServer.2022.Express).`n$installOutput"
    }

    Write-Host "SQL Express winget install hit language prompt issue (1009). Launching direct ENU installer fallback..." -ForegroundColor Yellow
    $tempInstaller = Join-Path $env:TEMP "SQL2022-SSEI-Expr.exe"
    $downloadUrl = "https://download.microsoft.com/download/5/1/4/5145fe04-4d30-4b85-b0d1-39533663a2f1/SQL2022-SSEI-Expr.exe"

    Invoke-WebRequest -Uri $downloadUrl -OutFile $tempInstaller
    $proc = Start-Process -FilePath $tempInstaller -ArgumentList "/ENU" -PassThru -Wait
    if ($proc.ExitCode -ne 0) {
        throw "Direct SQL Server installer exited with code $($proc.ExitCode). Please complete SQL Express setup manually and ensure instance SQLEXPRESS exists."
    }

    Write-Host "Direct ENU SQL Express installer completed." -ForegroundColor Green
}

function Repair-Odbc17MsiSource {
    Write-Host "Checking ODBC Driver 17 MSI source consistency..." -ForegroundColor Yellow

    $odbcMsiUrl = "https://download.microsoft.com/download/6/f/f/6ffefc73-39ab-4cc0-bb7c-4093d64c2669/en-US/17.10.6.1/x64/msodbcsql.msi"
    $odbcMsiPath = Join-Path $env:TEMP "msodbcsql.msi"

    Invoke-WebRequest -Uri $odbcMsiUrl -OutFile $odbcMsiPath

    $isInstalled = $false
    try {
        $installed = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*" -ErrorAction SilentlyContinue |
            Where-Object { $_.DisplayName -like "Microsoft ODBC Driver 17 for SQL Server*" } |
            Select-Object -First 1
        $isInstalled = $null -ne $installed
    }
    catch {
        $isInstalled = $false
    }

    if ($isInstalled) {
        Write-Host "ODBC Driver 17 detected; recaching/repairing from downloaded MSI..." -ForegroundColor Yellow
        $proc = Start-Process -FilePath "msiexec.exe" -ArgumentList @("/fvomus", "`"$odbcMsiPath`"", "IACCEPTMSODBCSQLLICENSETERMS=YES", "/qn", "/norestart") -PassThru -Wait
    }
    else {
        Write-Host "ODBC Driver 17 not detected; installing from downloaded MSI..." -ForegroundColor Yellow
        $proc = Start-Process -FilePath "msiexec.exe" -ArgumentList @("/i", "`"$odbcMsiPath`"", "IACCEPTMSODBCSQLLICENSETERMS=YES", "/qn", "/norestart") -PassThru -Wait
    }

    if ($proc.ExitCode -ne 0) {
        throw "ODBC Driver 17 MSI repair/install failed with exit code $($proc.ExitCode)."
    }

    Write-Host "ODBC Driver 17 MSI source is healthy." -ForegroundColor Green
}

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$checkScript = Join-Path $scriptDir "check-test-environment.ps1"

if (-not (Test-Path $checkScript)) {
    throw "Required script not found: $checkScript"
}

$selectedProfiles = @($Profiles)
if ($RunAllProfiles) {
    $selectedProfiles = @("Unit", "Integration", "Package", "Full")
}

if ($Install) {
    Write-Step "Install mode enabled"

    if (-not (Test-IsAdministrator)) {
        throw "Install mode requires an elevated PowerShell session (Run as Administrator)."
    }

    if (-not (Test-CommandExists -CommandName "winget")) {
        throw "winget is required for automated install mode. Install App Installer or run manual installs."
    }

    if (-not $SkipPwsh) {
        Invoke-WingetInstall -Id "Microsoft.PowerShell" -Name "PowerShell 7 (pwsh)" -Override "" -Locale ""
    }
    else {
        Write-Host "Skipping PowerShell 7 (pwsh) installation." -ForegroundColor DarkYellow
    }

    if (-not $SkipDotNet) {
        Invoke-WingetInstall -Id "Microsoft.DotNet.SDK.10" -Name ".NET SDK 10" -Override "" -Locale ""
    }
    else {
        Write-Host "Skipping .NET SDK installation." -ForegroundColor DarkYellow
    }

    if (-not $SkipBuildTools) {
        $buildToolsOverride = "--quiet --wait --norestart --nocache --add Microsoft.VisualStudio.Workload.MSBuildTools --add Microsoft.VisualStudio.Workload.WebBuildTools --includeRecommended"
        Invoke-WingetInstall -Id "Microsoft.VisualStudio.2022.BuildTools" -Name "Visual Studio Build Tools" -Override $buildToolsOverride -Locale ""
    }
    else {
        Write-Host "Skipping Build Tools installation." -ForegroundColor DarkYellow
    }

    if (-not $SkipSqlOdbc) {
        Invoke-WingetInstall -Id "Microsoft.msodbcsql.17" -Name "Microsoft ODBC Driver 17 for SQL Server" -Override "" -Locale ""
    }
    else {
        Write-Host "Skipping SQL ODBC driver installation." -ForegroundColor DarkYellow
    }

    if ($InstallWsl) {
        Invoke-WingetInstall -Id "Microsoft.WSL" -Name "Windows Subsystem for Linux" -Override "" -Locale ""
        Invoke-WingetInstall -Id $WslDistroId -Name "WSL distro ($WslDistroId)" -Override "" -Locale ""
    }
    else {
        Write-Host "Skipping WSL installation. Use -InstallWsl to include Linux packaging prerequisites." -ForegroundColor DarkYellow
    }

    if ($InstallWixToolset) {
        Invoke-WingetInstall -Id "WiXToolset.WiXToolset" -Name "WiX Toolset v3" -Override "" -Locale ""
    }
    else {
        Write-Host "Skipping WiX Toolset installation. Use -InstallWixToolset for installer tooling." -ForegroundColor DarkYellow
    }

    if ($InstallSqlExpress) {
        Repair-Odbc17MsiSource
        Install-SqlExpressWithFallback -OverrideArgs $SqlExpressOverride
    }
    else {
        Write-Host "Skipping SQL Server Express installation. Use -InstallSqlExpress to include local SQL engine setup." -ForegroundColor DarkYellow
    }

    if ($InstallIIS) {
        Write-Host "Enabling IIS Web Server role and IIS Management Scripting Tools..." -ForegroundColor Yellow
        & dism /online /enable-feature /featurename:IIS-WebServerRole /all /norestart
        if ($LASTEXITCODE -ne 0) {
            throw "Failed enabling IIS-WebServerRole."
        }

        & dism /online /enable-feature /featurename:IIS-ManagementScriptingTools /all /norestart
        if ($LASTEXITCODE -ne 0) {
            throw "Failed enabling IIS-ManagementScriptingTools."
        }
    }
    else {
        Write-Host "Skipping IIS feature installation. Use -InstallIIS for integration test setup." -ForegroundColor DarkYellow
    }

    Write-Host "Install step completed. Restart terminal/session if tools are not immediately visible in PATH." -ForegroundColor Green

    if (-not (Test-WixCaTargetsAvailable)) {
        Write-Host "WiX v3 MSBuild targets (Wix.CA.targets) were not detected in Visual Studio MSBuild paths." -ForegroundColor Yellow
        Write-Host "If legacy installer projects fail, install WiX Visual Studio build integration and re-run checks." -ForegroundColor Yellow
    }
}
else {
    Write-Step "Install mode disabled (check-only run)"
}

Write-Step "Running prerequisite checks"

$checkShell = if (Test-CommandExists -CommandName "pwsh") {
    "pwsh"
}
elseif (Test-CommandExists -CommandName "powershell") {
    "powershell"
}
else {
    $null
}

if ($null -eq $checkShell) {
    throw "Neither 'pwsh' nor 'powershell' was found in PATH. Install PowerShell before running prerequisite checks."
}

$failures = @()
foreach ($profile in $selectedProfiles) {
    Write-Host "Running profile: $profile" -ForegroundColor Yellow
    & $checkShell -File $checkScript -Profile $profile
    if ($LASTEXITCODE -ne 0) {
        $failures += $profile
    }
}

if ($failures.Count -gt 0) {
    Write-Host "`nSome profiles reported missing prerequisites: $($failures -join ', ')" -ForegroundColor Yellow
    exit 1
}

Write-Host "`nAll selected profiles passed: $($selectedProfiles -join ', ')" -ForegroundColor Green
exit 0
