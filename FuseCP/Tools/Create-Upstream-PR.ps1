param(
    [string]$Title,
    [string]$Repo = "FuseCP/FuseCP",
    [string]$Base = "main",
    [string]$Head = "FuseCPDevOPS:main",
    [string]$DraftFile = (Join-Path $PSScriptRoot "..\..\PR_DRAFT.md")
)

$ErrorActionPreference = "Stop"

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    throw "GitHub CLI 'gh' is required but was not found in PATH."
}

if (-not (Test-Path -Path $DraftFile -PathType Leaf)) {
    throw "Draft file not found: $DraftFile"
}

$draftBody = Get-Content -Path $DraftFile -Raw
if ([string]::IsNullOrWhiteSpace($draftBody)) {
    throw "Draft file is empty: $DraftFile"
}

$args = @(
    "pr", "create",
    "--repo", $Repo,
    "--base", $Base,
    "--head", $Head,
    "--body-file", $DraftFile
)

if (-not [string]::IsNullOrWhiteSpace($Title)) {
    $args += @("--title", $Title)
}

$prUrl = & gh @args
if ($LASTEXITCODE -ne 0) {
    throw "Failed to create upstream pull request."
}

if ([string]::IsNullOrWhiteSpace($prUrl)) {
    throw "Pull request was created but URL output was empty; draft file was not cleared."
}

Set-Content -Path $DraftFile -Value "" -Encoding UTF8 -NoNewline

Write-Host "Created upstream PR: $prUrl" -ForegroundColor Green
Write-Host "Cleared draft file: $DraftFile" -ForegroundColor Green