Set-StrictMode -Version Latest

function Write-Log {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory=$true)][string]$Message,
    [ValidateSet('INFO','WARN','ERROR')][string]$Level = 'INFO',
    [string]$Path
  )
  $ts = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
  $line = "[$ts][$Level] $Message"
  Write-Host $line
  if ($Path) {
    $dir = Split-Path -Parent $Path
    if ($dir -and -not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
    Add-Content -Path $Path -Value $line -Encoding UTF8
  }
}

function Ensure-Folder {
  [CmdletBinding()]
  param([Parameter(Mandatory=$true)][string]$Path)
  if (-not (Test-Path $Path)) {
    New-Item -ItemType Directory -Path $Path | Out-Null
  }
}

function Read-Settings {
  [CmdletBinding()]
  param([Parameter(Mandatory=$true)][string]$SettingsPath)
  if (-not (Test-Path $SettingsPath)) {
    throw "Nie znaleziono pliku settings: $SettingsPath. Skopiuj settings.example.json do settings.json i uzupełnij."
  }
  $raw = Get-Content -Path $SettingsPath -Raw -Encoding UTF8
  return ($raw | ConvertFrom-Json)
}

Export-ModuleMember -Function Write-Log, Ensure-Folder, Read-Settings
