# AEM Components

A selection of AEM components we have developed, generally in PowerShell. We run these with "Stash", an integration built for running PoSH scripts which ensures that a copy of the script is not left in ProgramData.


## Install-OpenDNS.ps1
Ensure "UmbrellaFingerprint", "UmbrellaOrgId", and "UmbrellaUserId" variables are set at the Site level, otherwise the script will fail to run.

## Install-Webroot.ps1
Ensure that a "WebrootKey" variable is set at the Site level, otherwise the script will fail to run.

##Remove-AEM.bat
The agent has a habit of just dropping off, and uninstalling from Add/Remove Programs isn't enough.

## Test-WANSpeed.ps1
Runs four tests from speedtest.net and then averages the result to confirm download speed.