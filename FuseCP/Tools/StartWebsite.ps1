Write-Host -ForegroundColor Green "
Ensure that you have created the EnterpriseServer Database
by executing test-createDB.bat and compiled FuseCP by
executing build-test.bat .

Configuration:

FuseCP Portal:

URL: http://localhost:9001
Login: serveradmin
Password: 1234


FuseCP Enterprise Server:
URL: http://127.0.0.1:9002
Database Login: FuseCP
Database Password: Password12


FuseCP Server:
URL: http://localhost:9003
Password: Password12
"

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
			if ($siteState -ne "Started") {
				Start-Website -Name $siteName
				Write-Host "Started IIS website: $siteName" -ForegroundColor Yellow
			}
			else {
				Write-Host "IIS website already started: $siteName" -ForegroundColor DarkYellow
			}
		}
		else {
			Write-Host "IIS website not found: $siteName" -ForegroundColor DarkYellow
		}
	}
}
catch {
	Write-Host "Unable to manage IIS websites. Run as Administrator and ensure IIS + WebAdministration are installed." -ForegroundColor Red
	Write-Host $_.Exception.Message -ForegroundColor Red
}

start http://localhost:9001

Read-Host "Press a key"


	
	
	
