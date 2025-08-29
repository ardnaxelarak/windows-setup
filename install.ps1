$packages = @(
    ,"Microsoft.VisualStudio.2022.Community"
    ,"Microsoft.VisualStudio.2022.BuildTools"
    ,"Microsoft.VisualStudioCode"
    ,"Zen-Team.Zen-Browser"
    ,"Klocman.BulkCrapUninstaller"
    ,"Discord.Discord"
    ,"OBSProject.OBSStudio"
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
    $info += , ($package, $hasUpdate, $installed, $hasUpdate)
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
        if ($item[2] -and !$item[3]) {
            $line += "    "
        } elseif ($item[1]) {
            $line += "[x] "
        } else {
            $line += "[ ] "
        }
        $line += $item[0].PadRight(45)
        if ($item[3]) {
            $line += " Update Available"
        } elseif (!$item[2]) {
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
            if (!$info[$pos][2] -or $info[$pos][3]) {
                $info[$pos][1] = !$info[$pos][1]
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
    if (!$item[1]) {
        continue
    }
    winget install -e --id $item[0] --accept-package-agreements
}

Pause
