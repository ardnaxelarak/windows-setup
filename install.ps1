$packages = @(
    ,"Microsoft.VisualStudio.2022.Community"
    ,"Microsoft.VisualStudio.2022.BuildTools"
    ,"Microsoft.VisualStudioCode"
    ,"Zen-Team.Zen-Browser"
    ,"Klocman.BulkCrapUninstaller"
    ,"Discord.Discord"
    ,"OBSProject.OBSStudio"
    ,"SourMesen.Mesen2"
    ,"Valve.Steam"
)

Clear-Host
Write-Host "Getting package information..."

$info = @()
$pos = 0
foreach ($package in $packages) {
    winget search -e --id $package | out-null
    if (!$?) {
        continue
    }
    winget list -e --id $package | out-null
    $installed = $?
    if ($installed) {
        ($upgrade = winget list --upgrade-available -e --id $package) | out-null
        $hasUpdate = !($upgrade -like "*No installed package found matching input criteria.")
    } else {
        $hasUpdate = $false
    }
    # winget install --id $package --accept-package-agreements
    $info += @{
        Package = $package
        Installed = $installed
        HasUpdate = $hasUpdate
        Selected = $hasUpdate
    }
}

function DrawMenu {
    $fc = $host.UI.RawUI.ForegroundColor
    $bc = $host.UI.RawUI.BackgroundColor

    Clear-Host
    Write-Host "  ====================================="
    Write-Host "  = Select Programs to Install/Update ="
    Write-Host "  ====================================="
    Write-Host
    $len = $info.Length
    for ($i = 0; $i -lt $len; $i++) {
        $item = $info[$i]
        $line = "  "
        if ($item.Installed -and !$item.HasUpdate) {
            $line += "    "
        } elseif ($item.Selected) {
            $line += "[x] "
        } else {
            $line += "[ ] "
        }
        $line += $item.Package.PadRight(45)
        if ($item.HasUpdate) {
            $line += " Update Available"
        } elseif (!$item.Installed) {
            $line += " Not Installed"
        }
        if ($i -eq $pos) {
            Write-Host $line -fore $bc -back $fc
        } else {
            Write-Host $line -fore $fc -back $bc
        }
    }
}

function Menu {
    $keycode = 0
    DrawMenu
    while ($keycode -ne 13) {
        $press = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        $keycode = $press.virtualkeycode
        if ($keycode -eq 38) {
            $pos--
            if ($pos -lt 0) {
                $pos = $info.Length - 1
            }
        } elseif ($keycode -eq 40) {
            $pos++
            if ($pos -ge $info.Length) {
                $pos = 0
            }
        } elseif ($keycode -eq 32) {
            if (!$info[$pos].Installed -or $info[$pos].HasUpdate) {
                $info[$pos].Selected = !$info[$pos].Selected
            }
        }
        DrawMenu
    }
}

Menu

$pos = -1
DrawMenu
Write-Host

foreach ($item in $info) {
    if (!$item.Selected) {
        continue
    }
    winget install -e --id $item.Package --accept-package-agreements
}

Pause
