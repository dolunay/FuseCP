param(
    [string]$RepoRoot,
    [string[]]$ScopeSolutions = @(
        "FuseCP.WebPortal.sln",
        "FuseCP.EnterpriseServer.sln",
        "FuseCP.Server.sln"
    ),
    [string]$TargetSolution = "FuseCP.sln",
    [switch]$WriteReport,
    [string]$JsonOutputPath = "artifacts/scope-sln-inclusion-report.json",
    [string]$MarkdownOutputPath = "artifacts/scope-sln-inclusion-report.md"
)

$ErrorActionPreference = "Stop"

if ([string]::IsNullOrWhiteSpace($RepoRoot)) {
    $RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
}

$repoRootPath = (Resolve-Path $RepoRoot).Path
$sourcesRoot = Join-Path $repoRootPath "FuseCP\Sources"
$targetSolutionPath = Join-Path $repoRootPath $TargetSolution

if (-not (Test-Path $targetSolutionPath)) {
    throw "Target solution not found: $targetSolutionPath"
}

$resolvedScopeSolutions = @()
foreach ($scopeSolution in $ScopeSolutions) {
    $scopePath = Join-Path $sourcesRoot $scopeSolution
    if (-not (Test-Path $scopePath)) {
        throw "Scope solution not found: $scopePath"
    }

    $resolvedScopeSolutions += $scopePath
}

$projectLineRegex = '^Project\("\{[^\}]+\}"\)\s*=\s*"[^"]+",\s*"([^"]+\.(csproj|vbproj|fsproj|vcxproj|shproj))",\s*"\{[^\}]+\}"'

function Get-SolutionProjects {
    param([string]$SolutionPath)

    $solutionBase = Split-Path $SolutionPath -Parent
    $projects = @()

    foreach ($line in (Get-Content $SolutionPath)) {
        $match = [regex]::Match($line, $projectLineRegex)
        if (-not $match.Success) {
            continue
        }

        $relativePath = $match.Groups[1].Value
        $fullPath = [System.IO.Path]::GetFullPath((Join-Path $solutionBase $relativePath))

        if ($fullPath.StartsWith($repoRootPath, [System.StringComparison]::OrdinalIgnoreCase)) {
            $normalized = $fullPath.Substring($repoRootPath.Length + 1) -replace '\\', '/'
        }
        else {
            $normalized = $fullPath -replace '\\', '/'
        }

        $projects += $normalized
    }

    return $projects | Sort-Object -Unique
}

$fuseCpProjects = Get-SolutionProjects -SolutionPath $targetSolutionPath
$scopeProjectMap = @{}

foreach ($scopeSolutionPath in $resolvedScopeSolutions) {
    $scopeName = Split-Path $scopeSolutionPath -Leaf
    $scopeProjectMap[$scopeName] = Get-SolutionProjects -SolutionPath $scopeSolutionPath
}

$scopeUnion = @($scopeProjectMap.Values | ForEach-Object { $_ }) | Sort-Object -Unique
$records = @()

foreach ($project in $scopeUnion) {
    $inScopes = @()
    foreach ($scopeName in $scopeProjectMap.Keys) {
        if ($scopeProjectMap[$scopeName] -contains $project) {
            $inScopes += $scopeName
        }
    }

    $records += [pscustomobject]@{
        project      = $project
        inFuseCpSln  = ($fuseCpProjects -contains $project)
        inScopes     = @($inScopes | Sort-Object)
    }
}

$missingRecords = @($records | Where-Object { -not $_.inFuseCpSln } | Sort-Object project)

$summary = [pscustomobject]@{
    generatedAt          = (Get-Date).ToString("o")
    scopeSolutions       = @($scopeProjectMap.Keys | Sort-Object)
    scopeUnionCount      = $scopeUnion.Count
    includedInFuseCpCount = (@($records | Where-Object inFuseCpSln).Count)
    missingInFuseCpCount = $missingRecords.Count
}

if ($WriteReport) {
    $jsonReportPath = Join-Path $repoRootPath $JsonOutputPath
    $mdReportPath = Join-Path $repoRootPath $MarkdownOutputPath

    $jsonDir = Split-Path $jsonReportPath -Parent
    $mdDir = Split-Path $mdReportPath -Parent

    if (-not (Test-Path $jsonDir)) {
        New-Item -Path $jsonDir -ItemType Directory -Force | Out-Null
    }

    if (-not (Test-Path $mdDir)) {
        New-Item -Path $mdDir -ItemType Directory -Force | Out-Null
    }

    [pscustomobject]@{
        summary  = $summary
        projects = $records
    } | ConvertTo-Json -Depth 6 | Set-Content -Path $jsonReportPath -Encoding UTF8

    $md = @()
    $md += "# Scope Solution Inclusion Report"
    $md += ""
    $md += "Generated: $($summary.generatedAt)"
    $md += ""
    $md += "## Summary"
    $md += "- Scope solutions: $((@($summary.scopeSolutions) -join ', '))"
    $md += "- Union project count: $($summary.scopeUnionCount)"
    $md += "- Included in FuseCP.sln: $($summary.includedInFuseCpCount)"
    $md += "- Missing in FuseCP.sln: $($summary.missingInFuseCpCount)"
    $md += ""
    $md += "## Projects"

    foreach ($record in ($records | Sort-Object project)) {
        $status = if ($record.inFuseCpSln) { "included" } else { "missing" }
        $md += "- [$status] $($record.project) (scopes: $((@($record.inScopes) -join ', ')))"
    }

    Set-Content -Path $mdReportPath -Value $md -Encoding UTF8

    Write-Host "Wrote: $jsonReportPath"
    Write-Host "Wrote: $mdReportPath"
}

Write-Host "Scope union projects: $($summary.scopeUnionCount)"
Write-Host "Included in ${TargetSolution}: $($summary.includedInFuseCpCount)"
Write-Host "Missing in ${TargetSolution}: $($summary.missingInFuseCpCount)"

if ($missingRecords.Count -gt 0) {
    Write-Host ""
    Write-Host "Projects present in scope solutions but missing in ${TargetSolution}:" -ForegroundColor Red
    foreach ($missing in $missingRecords) {
        Write-Host "- $($missing.project) [scopes: $((@($missing.inScopes) -join ', '))]" -ForegroundColor Red
    }

    exit 1
}

Write-Host "Solution sync check passed." -ForegroundColor Green
exit 0
