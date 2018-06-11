$HideARP = 0
$HideUI = 1
$OrgId = ${env:UmbrellaOrgId}
$FingerPrint = ${env:UmbrellaFingerprint} 
$UserID = ${env:UmbrellaUserId}

If(!$env:UmbrellaOrgId -Or !$env:UmbrellaFingerprint -Or !$env:UmbrellaUserId) {
    Write-Output "Environment variables not set, please check Site Settings."
}
Else {
    If(Test-Path hklm:\SYSTEM\CurrentControlSet\services\Umbrella_RC) {
        Write-Output "Umbrella is already installed on this system, skipping installation."
    }
    Else {
        Invoke-WebRequest -Uri http://shared.opendns.com/roaming/enterprise/release/win/production/Setup.msi -OutFile Setup.msi
        msiexec /i Setup.msi /qn ORG_ID=${env:UmbrellaOrgId} ORG_FINGERPRINT=${env:UmbrellaFingerprint} USER_ID=${env:UmbrellaUserId} HIDE_UI=$HideUI HIDE_ARP=$HideARP

        $SleptFor = 0
        $DoLoop = $True

        While($DoLoop) {
            Start-Sleep 1
            $SleptFor += 1
            If(Test-Path hklm:\SYSTEM\CurrentControlSet\services\Umbrella_RC) {
                Write-Output "Umbrella was succesfully installed after ${SleptFor} seconds."
                $DoLoop = $False
            }
            Else {
                If($SleptFor -gt 60) {
                    Write-Output "msiexec started, but Umbrella may not have been installed correctly."
                    $DoLoop = $False
                }
            }
        }

    }
}
