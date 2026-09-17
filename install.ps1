# DicDoc Installations-Skript
#
# Laedt die neueste DicDoc-Version herunter, legt sie unter einem festen
# Dateinamen ab (wichtig fuer das automatische Selbst-Update der App) und
# richtet einen Autostart-Eintrag ein (Start beim Windows-Login, minimiert
# im System-Tray).
#
# Ausfuehren (PowerShell):
#   irm https://raw.githubusercontent.com/infoAZSuhr/DicDoc-releases/main/install.ps1 | iex

$ErrorActionPreference = "Stop"

$repo = "infoAZSuhr/DicDoc-releases"
$installDir = Join-Path $env:LOCALAPPDATA "DicDoc"
$exePath = Join-Path $installDir "DicDoc.exe"

Write-Host "Suche neueste DicDoc-Version ..."
$release = Invoke-RestMethod -Uri "https://api.github.com/repos/$repo/releases/latest"
$asset = $release.assets | Where-Object { $_.name -like "DicDoc-*.exe" } | Select-Object -First 1

if (-not $asset) {
    Write-Error "Keine .exe im neuesten Release gefunden."
    exit 1
}

Write-Host "Gefunden: $($asset.name) ($($release.tag_name))"

New-Item -ItemType Directory -Force -Path $installDir | Out-Null

# Laeuft DicDoc gerade? Dann kurz beenden, damit die Datei nicht gesperrt ist.
Get-Process -Name "DicDoc" -ErrorAction SilentlyContinue | Stop-Process -Force

Write-Host "Lade herunter nach $exePath ..."
Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $exePath

# Autostart-Verknuepfung anlegen (startet minimiert im Tray beim Windows-Login)
$startupFolder = [Environment]::GetFolderPath("Startup")
$shortcutPath = Join-Path $startupFolder "DicDoc.lnk"
$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $exePath
$shortcut.WorkingDirectory = $installDir
$shortcut.Save()

Write-Host ""
Write-Host "Fertig. DicDoc ist installiert unter: $exePath"
Write-Host "Autostart eingerichtet - startet automatisch (minimiert im Tray) beim naechsten Windows-Login."
Write-Host ""

$startNow = Read-Host "Jetzt starten? (j/n)"
if ($startNow -eq "j") {
    Start-Process $exePath
}
