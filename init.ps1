function Refresh-Path {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe
Refresh-Path

$packages = @(
    ,"NirSoft.AdvancedRun"
    ,"jqlang.jq"
    ,"Git.Git"
    ,"vim.vim"
    ,"Maximus5.ConEmu"
    ,"astral-sh.uv"
    ,"Casey.Just"
)

foreach ($package in $packages) {
    winget install -e --id $package --accept-package-agreements
}
Refresh-Path

# set config for ConEmu
& "C:\Program Files\ConEmu\ConEmu64" -LoadCfgFile "$PSScriptRoot\ConEmu.xml" -SaveCfgFile "$HOME\AppData\Roaming\ConEmu.xml" -Exit

# set up directories for vim
if (!(Test-Path ~/vimfiles)) {
    New-Item -Path ~/vimfiles -ItemType directory
}
if (!(Test-Path ~/vimfiles/tmp)) {
    New-Item -Path ~/vimfiles/tmp -ItemType directory
}
if (!(Test-Path ~/vimfiles/tmp/undo)) {
    New-Item -Path ~/vimfiles/tmp/undo -ItemType directory
}
if (!(Test-Path ~/vimfiles/tmp/backup)) {
    New-Item -Path ~/vimfiles/tmp/backup -ItemType directory
}
if (!(Test-Path ~/vimfiles/tmp/swap)) {
    New-Item -Path ~/vimfiles/tmp/swap -ItemType directory
}

# set vimrc file for gVim
Copy-Item "$PSScriptRoot\_vimrc" -Destination "$HOME\_vimrc"

Copy-Item "$PSScriptRoot\vimfiles\*" -Destination "$HOME\vimfiles" -Recurse -Force

uv python install

Pause
