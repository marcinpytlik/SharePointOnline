<#
.SYNOPSIS
    Raport uzycia OneDrive przez Microsoft Graph Reports.
#>
param(
    [ValidateSet('D7','D30','D90','D180')]
    [string]$Period = 'D30',
    [string]$OutputRoot = 'D:\M365Reports'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Import-Module Microsoft.Graph.Reports

$DateStamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$OutDir = Join-Path $OutputRoot "OneDriveUsage_$DateStamp"
New-Item -Path $OutDir -ItemType Directory -Force | Out-Null
$CsvPath = Join-Path $OutDir "onedrive_usage_${Period}_$DateStamp.csv"

Connect-MgGraph -Scopes 'Reports.Read.All'
Get-MgReportOneDriveUsageAccountDetail -Period $Period -OutFile $CsvPath
Disconnect-MgGraph

Write-Host "Report saved: $CsvPath"
