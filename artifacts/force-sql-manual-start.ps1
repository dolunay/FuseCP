$ErrorActionPreference = 'Stop'
$serviceName = 'MSSQL$SQLEXPRESS'
$service = Get-WmiObject Win32_Service -Filter "Name='$serviceName'"
if ($null -eq $service) {
  Write-Host "Service not found: $serviceName"
  exit 2
}
$result = $service.ChangeStartMode('Manual')
Write-Host "ChangeStartModeReturn=$($result.ReturnValue)"
sc.exe qc $serviceName
Stop-Service -Name $serviceName -Force -ErrorAction SilentlyContinue
exit 0
