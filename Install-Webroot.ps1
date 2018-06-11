$ErrorActionPreference = "Stop"
$VerbosePreference = "Continue"

$webrootKey = $env:WebrootKey
$webrootFound = $False

If(!$webrootKey) {
    Write-Error "No WebrootKey for this customer."
    Exit 1
}

ForEach($pfDir in @(${env:ProgramFiles(x86)}, $env:ProgramFiles)) {
    if($pfDir -and (Test-Path "$pfDir\Webroot")) {
        $webrootFound = "$pfDir\Webroot"
    }
}

If($webrootFound) {
    Write-Verbose "Webroot is installed at $webrootFound"
    Exit 0
}
Else {
    Write-Verbose "Webroot is not installed"
    Invoke-WebRequest -Uri http://anywhere.webrootcloudav.com/zerol/wsasme.exe -OutFile wsasme.exe
    .\wsasme.exe /key=${env:WebrootKey} /exeshowaddremove /silent
    Exit $LASTEXITCODE
}
