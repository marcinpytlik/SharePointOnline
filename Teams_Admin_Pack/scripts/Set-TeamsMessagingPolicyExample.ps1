<#
.SYNOPSIS
Przykład bezpiecznej zmiany polityki wiadomości (SupportsShouldProcess / -WhatIf).
.DESCRIPTION
To jest template do kontrolowanych zmian – najpierw raport, potem zmiana na jednej grupie użytkowników.
#>
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='High')]
param(
  [Parameter(Mandatory=$true)][string]$Identity,
  [Parameter(Mandatory=$true)][bool]$AllowUserChat
)

$ErrorActionPreference = 'Stop'
Import-Module MicrosoftTeams -ErrorAction Stop
Connect-MicrosoftTeams | Out-Null

$action = "Set-CsTeamsMessagingPolicy Identity=$Identity AllowUserChat=$AllowUserChat"
if ($PSCmdlet.ShouldProcess($Identity, $action)) {
  Set-CsTeamsMessagingPolicy -Identity $Identity -AllowUserChat $AllowUserChat
  Write-Host "OK."
}
