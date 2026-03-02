$ErrorActionPreference = "Stop"

$processes = Get-Process -Name "devenv" -ErrorAction SilentlyContinue
if ($null -eq $processes -or $processes.Count -eq 0) {
    Write-Host "No Visual Studio instances are running." -ForegroundColor DarkYellow
    exit 0
}

foreach ($process in $processes) {
    try {
        $closed = $process.CloseMainWindow()
        if ($closed) {
            Write-Host "Requested close for devenv PID $($process.Id)." -ForegroundColor Yellow
        }
        else {
            Write-Host "CloseMainWindow not available for PID $($process.Id); forcing stop." -ForegroundColor DarkYellow
        }
    }
    catch {
        Write-Host "Could not request close for PID $($process.Id): $($_.Exception.Message)" -ForegroundColor DarkYellow
    }
}

Start-Sleep -Seconds 3

$remaining = Get-Process -Name "devenv" -ErrorAction SilentlyContinue
if ($null -ne $remaining -and $remaining.Count -gt 0) {
    foreach ($process in $remaining) {
        try {
            Stop-Process -Id $process.Id -Force
            Write-Host "Forced close for devenv PID $($process.Id)." -ForegroundColor Yellow
        }
        catch {
            Write-Host "Could not force-close PID $($process.Id): $($_.Exception.Message)" -ForegroundColor Red
        }
    }
}

Write-Host "Closing VS task completed." -ForegroundColor Green
