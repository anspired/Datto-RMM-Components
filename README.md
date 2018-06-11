# AEM Components

A selection of AEM components we have built, generally in PowerShell

 We run these with "Stash", an integration built for running PoSH scripts which ensures that a copy of the script is not left in ProgramData.


## Install-OpenDNS.ps1
Ensure "UmbrellaFingerprint", "UmbrellaOrgId", and "UmbrellaUserId" variables are set at the Site level, otherwise the script will fail to run.

## Install-Webroot.ps1
Ensure that a "WebrootKey" variable is set at the Site level, otherwise the script will fail to run.