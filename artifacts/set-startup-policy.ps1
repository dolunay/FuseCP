$ErrorActionPreference = 'Continue'
$log = 'c:\FuseCP\FuseCP\artifacts\startup-policy.log'
"Starting startup-policy update $(Get-Date -Format o)" | Out-File -FilePath $log -Encoding utf8
$targets = @('MSSQL$SQLEXPRESS','W3SVC')
foreach($name in $targets){
  $svc = Get-Service -Name $name -ErrorAction SilentlyContinue
  if($null -eq $svc){
    "Service not found: $name" | Out-File -FilePath $log -Append -Encoding utf8
    continue
  }

  "Setting startup to Manual: $name" | Out-File -FilePath $log -Append -Encoding utf8
  try {
    Set-Service -Name $name -StartupType Manual -ErrorAction Stop
  }
  catch {
    "Set-Service failed for $name: $($_.Exception.Message)" | Out-File -FilePath $log -Append -Encoding utf8
  }

  $svc.Refresh()
  if($svc.Status -eq 'Running'){
    "Stopping running service: $name" | Out-File -FilePath $log -Append -Encoding utf8
    try {
      Stop-Service -Name $name -Force -ErrorAction Stop
    }
    catch {
      "Stop-Service failed for $name: $($_.Exception.Message)" | Out-File -FilePath $log -Append -Encoding utf8
    }
  }
}
"Shutting down WSL" | Out-File -FilePath $log -Append -Encoding utf8
try {
  wsl --shutdown | Out-Null
}
catch {
  "WSL shutdown error: $($_.Exception.Message)" | Out-File -FilePath $log -Append -Encoding utf8
}
"Completed startup-policy update $(Get-Date -Format o)" | Out-File -FilePath $log -Append -Encoding utf8
