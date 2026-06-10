<#
.SYNOPSIS
Raport uprawnień PnP dla wybranego site'a: ownerzy, grupy, unikalne uprawnienia bibliotek (opcjonalnie item-level).
.DESCRIPTION
To jest narzędzie „na incydent”: kto ma dostęp i skąd.
.PARAMETER SiteUrl
Url site’a.
.PARAMETER OutputPath
Folder na raporty.
.PARAMETER IncludeItemLevel
Uwaga: może być kosztowne czasowo. Domyślnie OFF.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)][string]$SiteUrl,
  [Parameter(Mandatory=$true)][string]$OutputPath,
  [switch]$IncludeItemLevel
)

$ErrorActionPreference = 'Stop'
Import-Module PnP.PowerShell -ErrorAction Stop

if (-not (Test-Path $OutputPath)) { New-Item -ItemType Directory -Path $OutputPath | Out-Null }

Connect-PnPOnline -Url $SiteUrl -Interactive

$stamp = Get-Date -Format "yyyyMMdd_HHmmss"
$base = Join-Path $OutputPath ("SPO_Permissions_" + $stamp)

# Site admins
$admins = Get-PnPSiteCollectionAdmin | Select-Object Title, LoginName, Email
$admins | Export-Csv -NoTypeInformation -Encoding UTF8 -Path ($base + "_SiteCollectionAdmins.csv")

# SharePoint groups + members
$groups = Get-PnPGroup
$groupRows = foreach ($g in $groups) {
  $members = Get-PnPGroupMember -Identity $g
  foreach ($m in $members) {
    [pscustomobject]@{
      GroupTitle = $g.Title
      GroupLogin = $g.LoginName
      MemberTitle = $m.Title
      MemberLogin = $m.LoginName
      MemberEmail = $m.Email
      PrincipalType = $m.PrincipalType
    }
  }
}
$groupRows | Export-Csv -NoTypeInformation -Encoding UTF8 -Path ($base + "_GroupsMembers.csv")

# Libraries with unique permissions
$lists = Get-PnPList | Where-Object { -not $_.Hidden }
$unique = @()
foreach ($l in $lists) {
  $ctx = Get-PnPContext
  $ctx.Load($l, "HasUniqueRoleAssignments","Title","RootFolder","BaseTemplate")
  $ctx.ExecuteQuery()

  if ($l.HasUniqueRoleAssignments) {
    $unique += [pscustomobject]@{
      Title = $l.Title
      Url = $l.RootFolder.ServerRelativeUrl
      BaseTemplate = $l.BaseTemplate
      HasUniqueRoleAssignments = $true
    }
  }
}
$unique | Export-Csv -NoTypeInformation -Encoding UTF8 -Path ($base + "_Lists_UniquePermissions.csv")

if ($IncludeItemLevel) {
  # Item-level unique permissions (ostrożnie)
  $itemRows = @()
  foreach ($l in $lists) {
    Write-Host "Skan listy: $($l.Title)"
    $items = Get-PnPListItem -List $l -PageSize 500 -Fields "FileRef","FileLeafRef","Title"
    foreach ($it in $items) {
      $hasUnique = $false
      try {
        $ctx = Get-PnPContext
        $ctx.Load($it, "HasUniqueRoleAssignments")
        $ctx.ExecuteQuery()
        $hasUnique = $it.HasUniqueRoleAssignments
      } catch { }
      if ($hasUnique) {
        $ref = $it.FieldValues["FileRef"]
        $leaf = $it.FieldValues["FileLeafRef"]
        $itemRows += [pscustomobject]@{
          ListTitle = $l.Title
          ItemName = $leaf
          ItemRef = $ref
          HasUniqueRoleAssignments = $true
        }
      }
    }
  }
  $itemRows | Export-Csv -NoTypeInformation -Encoding UTF8 -Path ($base + "_Items_UniquePermissions.csv")
}

Write-Host "OK. Raporty: $base*"
