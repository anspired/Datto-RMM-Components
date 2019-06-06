#We need a Win32 class to take ownership of the Registry key
$definition = @"
using System;
using System.Runtime.InteropServices; 

namespace Win32Api
{

    public class NtDll
    {
        [DllImport("ntdll.dll", EntryPoint="RtlAdjustPrivilege")]
        public static extern int RtlAdjustPrivilege(ulong Privilege, bool Enable, bool CurrentThread, ref bool Enabled);
    }
}
"@ 

Add-Type -TypeDefinition $definition -PassThru | Out-Null
[Win32Api.NtDll]::RtlAdjustPrivilege(9, $true, $false, [ref]$false) | Out-Null

#Setting ownership to Administrators
$key = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey("SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\DefaultMediaCost",[Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree,[System.Security.AccessControl.RegistryRights]::takeownership)
$acl = $key.GetAccessControl()
$acl.SetOwner([System.Security.Principal.NTAccount]"Administrators")
$key.SetAccessControl($acl)

#Giving Administrators full control to the key
$rule = New-Object System.Security.AccessControl.RegistryAccessRule ([System.Security.Principal.NTAccount]"Administrators","FullControl","Allow")
$acl.SetAccessRule($rule)
$key.SetAccessControl($acl)

#Setting 3G/4G not metered
$path = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\DefaultMediaCost"
$3Gname = "3G"
$4Gname = "4G"
$3Gmetered = Get-ItemProperty -Path $path | Select-Object -ExpandProperty $3Gname
$4Gmetered = Get-ItemProperty -Path $path | Select-Object -ExpandProperty $4Gname

Clear
if ($3Gmetered -eq 2){
        New-ItemProperty -Path $path -Name $3Gname -Value "1" -PropertyType DWORD -Force | Out-Null
    } 

Clear
if ($4Gmetered -eq 2) {
        New-ItemProperty -Path $path -Name $4Gname -Value "1" -PropertyType DWORD -Force | Out-Null

}