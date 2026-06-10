# 1. Logowanie do Graph
Connect-MgGraph -Scopes "Organization.Read.All"

# 2. Tenant ID
Get-MgOrganization | Select-Object Id, DisplayName

# 3. Domeny tenanta
Get-MgOrganization |
    Select-Object -ExpandProperty VerifiedDomains |
    Select-Object Name, IsInitial, IsDefault

# 4. Wyliczenie SharePoint URL
$org = Get-MgOrganization
$tenantDomain = ($org.VerifiedDomains | Where-Object IsInitial -eq $true | Select-Object -First 1).Name
$tenantShortName = $tenantDomain.Replace(".onmicrosoft.com", "")

$sharePointRootUrl = "https://$tenantShortName.sharepoint.com"
$sharePointAdminUrl = "https://$tenantShortName-admin.sharepoint.com"

[pscustomobject]@{
    TenantDomain       = $tenantDomain
    TenantShortName    = $tenantShortName
    SharePointRootUrl  = $sharePointRootUrl
    SharePointAdminUrl = $sharePointAdminUrl
}

# 5. Utworzenie aplikacji PnP i uzyskanie ClientId
Register-PnPEntraIDAppForInteractiveLogin `
  -ApplicationName "PnP PowerShell - Corporate Portal Deployment" `
  -Tenant $tenantDomain `
  -Interactive