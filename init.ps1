function Refresh-Path {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe
Refresh-Path

$packages = @(
    ,"jqlang.jq"
    ,"Git.Git"
    ,"vim.vim"
    ,"Maximus5.ConEmu"
    ,"Microsoft.VisualStudio.2022.Community"
    ,"Microsoft.VisualStudio.2022.BuildTools"
    ,"Microsoft.VisualStudioCode"
    ,"astral-sh.uv"
    ,"Zen-Team.Zen-Browser"
    ,"Klocman.BulkCrapUninstaller"
    ,"OBSProject.OBSStudio"
    ,"Discord.Discord"
)

foreach ($package in $packages) {
    winget install --id $package --accept-package-agreements
}
Refresh-Path

# always show full context menu
if (!(Test-Path -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32")) {
    if (!(Test-Path -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}")) {
        New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}"
    }
    New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Value {}
}

# show file extensions in Explorer
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name HideFileExt -Value 0
# show hidden files in Explorer
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name Hidden -Value 1
# remove ads in Explorer
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name ShowSyncProviderNotifications -Value 0

# remove ads in Start Menu
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name Start_IrisRecommendations -Value 0

# taskbar on left
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name TaskbarAl -Value 0

# remove taskbar copilot button
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name ShowCopilotButton -Value 0

# remove taskbar widgets button
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name TaskbarDa -Value 0

# remove task view button
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name ShowTaskViewButton -Value 0

# remove ads from Windows Search
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" -Name IsDynamicSearchBoxEnabled -Value 0

# remove ads from lock screen
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name RotatingLockScreenEnabled -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name RotatingLockScreenOverlayEnabled -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name SubscribedContent-338387Enabled -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name SubscribedContent-338389Enabled -Value 0

# disable showing windows tips
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name SoftLandingEnabled -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name ScoobeSystemSettingEnabled -Value 0

# disable settings app suggestions
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name SubscribedContent-338393Enabled -Value 0

# disable automatic app installs
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name SilentInstalledAppsEnabled -Value 0

# disable personalized ads
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name Enabled -Value 0

# disable tailored experiences
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" -Name TailoredExperiencesWithDiagnosticDataEnabled -Value 0

# remove searchbox from taskbar
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name SearchTaskbarMode -Value 0

# set config for ConEmu
& "C:\Program Files\ConEmu\ConEmu64" -LoadCfgFile "$PSScriptRoot\ConEmu.xml" -SaveCfgFile "$HOME\AppData\Roaming\ConEmu.xml" -Exit

# set up directories for vim
if (!(Test-Path ~/.vim)) {
    New-Item -Path ~/.vim -ItemType directory
}
if (!(Test-Path ~/.vim/tmp)) {
    New-Item -Path ~/.vim/tmp -ItemType directory
}
if (!(Test-Path ~/.vim/tmp/undo)) {
    New-Item -Path ~/.vim/tmp/undo -ItemType directory
}
if (!(Test-Path ~/.vim/tmp/backup)) {
    New-Item -Path ~/.vim/tmp/backup -ItemType directory
}
if (!(Test-Path ~/.vim/tmp/swap)) {
    New-Item -Path ~/.vim/tmp/swap -ItemType directory
}

# set vimrc file for gVim
Copy-Item "$PSScriptRoot\_vimrc" -Destination "$HOME\_vimrc"

uv python install

Pause
