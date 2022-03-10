# if not admin run the block
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) 
{ 
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; 
    Write-Output "Admin is required to add to windows defender";
    exit 
}
$old=$pwd;
Set-Location "$Home/documents"
mkdir synapse_x_install -Force
Write-Output "created install folder, now adding it to be excluded from windows defender"
Add-MpPreference -ExclusionPath "$pwd/synapse_x_install"
Set-Location ./synapse_x_install
Remove-Item -Recurse -Force ./*
if ((New-Object System.Net.WebClient).DownloadString("https://cdn1.synapsecdn.to/download.html") -match '(?ms)<a class="button".* href="(?<url>.*?)".*<\/a>') {
    Write-Output "Okay found synapse download url, starting download."
    Invoke-WebRequest -Uri $matches.url -OutFile "synapse.zip"
    Expand-Archive "synapse.zip" -Verbose
    Move-Item .\synapse\**\* . -Force
    $res = Read-Host "Synapse installed, Would you like to add a shortcut to desktop to run it? if not i will just open the directory. [Y/N]"
    if ($res -eq "y") {
        $WshShell = New-Object -comObject WScript.Shell
        $Shortcut = $WshShell.CreateShortcut("$Home\Desktop\Synapse X.lnk")
        $Shortcut.TargetPath = "$pwd/Synapse Launcher.exe"
        $Shortcut.Save()
    }
} else {
    Write-Output "Unable to find download for synapse x, go spam &luna#0001 on discord"  
    Read-Host "Press any key to exit..."
}

explorer.exe .
Set-Location $old