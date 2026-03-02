param(
    [switch]$SkipShutdown
)

$scriptPath = Join-Path $PSScriptRoot "DoneForToday.ps1"
if (-not (Test-Path $scriptPath)) {
    throw "Required script not found: $scriptPath"
}

if ($SkipShutdown) {
    & $scriptPath -SkipShutdown
}
else {
    & $scriptPath
}
