@echo off
taskkill /f /im gui.exe 2>nul
echo Waiting for AEM to be removed...
"C:\Program Files (x86)\CentraStage\uninst.exe" 2>nul
TIMEOUT /T 10 /NOBREAK 2>nul
rmdir "C:\Program Files (x86)\CentraStage" /S /Q 2>nul
rmdir "C:\Windows\System32\config\systemprofile\AppData\Local\CentraStage" /S /Q 2>nul
rmdir "C:\Windows\SysWOW64\config\systemprofile\AppData\Local\CentraStage" /S /Q 2>nul
rmdir "%userprofile%\AppData\Local\CentraStage" /S /Q 2>nul
rmdir "%allusersprofile%\CentraStage" /S /Q 2>nul
REG delete "HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run" /v CentraStage /f 2>nul
echo Done...