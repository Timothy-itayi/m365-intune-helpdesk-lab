<#
.SYNOPSIS  Offboards a user: blocks sign-in, revokes sessions, removes licences and group memberships.
.EXAMPLE   ./scripts/Remove-Leaver.ps1 -UserPrincipalName ben.carter@helpdeskco123.onmicrosoft.com -TicketRef INC-0004 -WhatIf
#>
#Requires -Version 7.0
[CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
param(
    [Parameter(Mandatory)][string]$UserPrincipalName,
    [string]$TicketRef = 'N/A'
)
$ErrorActionPreference = 'Stop'
if (-not (Get-MgContext)) { throw "Not connected. Run Connect-MgGraph first." }

$user = Get-MgUser -UserId $UserPrincipalName -Property Id,DisplayName,UserPrincipalName,AccountEnabled,AssignedLicenses
$steps = @()

if ($PSCmdlet.ShouldProcess($user.UserPrincipalName, "Offboard user")) {

    # 1. Block sign-in and end active sessions
    Update-MgUser -UserId $user.Id -AccountEnabled:$false
    Revoke-MgUserSignInSession -UserId $user.Id | Out-Null
    $steps += 'Sign-in blocked; sessions revoked'

    # 2. Change department so dynamic groups drop the user
    Update-MgUser -UserId $user.Id -Department 'Leaver'
    $steps += "Department set to 'Leaver' (dynamic groups will update)"

    # 3. Remove licences
    $skuIds = @($user.AssignedLicenses.SkuId)
    if ($skuIds.Count -gt 0) {
        Set-MgUserLicense -UserId $user.Id -AddLicenses @() -RemoveLicenses $skuIds | Out-Null
        $steps += "Removed $($skuIds.Count) licence(s)"
    }

    # 4. Remove from static (assigned) groups; dynamic groups can't be edited by hand
    foreach ($m in Get-MgUserMemberOf -UserId $user.Id -All) {
        if ($m.AdditionalProperties['@odata.type'] -ne '#microsoft.graph.group') { continue }
        $g = Get-MgGroup -GroupId $m.Id
        if ($g.GroupTypes -contains 'DynamicMembership') { continue }
        Remove-MgGroupMemberByRef -GroupId $g.Id -DirectoryObjectId $user.Id
        $steps += "Removed from group $($g.DisplayName)"
    }

    [pscustomobject]@{
        Timestamp = (Get-Date).ToString('s'); Action = 'Leaver'; UPN = $user.UserPrincipalName
        Department = 'Leaver'; Ticket = $TicketRef; By = (Get-MgContext).Account
    } | Export-Csv -Path (Join-Path $PSScriptRoot '../logs/actions.csv') -Append -NoTypeInformation

    $steps | ForEach-Object { Write-Host " - $_" }
}