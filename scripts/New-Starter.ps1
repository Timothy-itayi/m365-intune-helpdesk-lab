<#
.SYNOPSIS  Creates a new starter account, assigns a licence and logs the action.
.EXAMPLE   ./scripts/New-Starter.ps1 -GivenName Ava -Surname Nguyen -Department Sales -JobTitle "Account Executive" -WhatIf
#>
#Requires -Version 7.0
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)][string]$GivenName,
    [Parameter(Mandatory)][string]$Surname,
    [Parameter(Mandatory)][ValidateSet('Sales','Operations','Finance')][string]$Department,
    [Parameter(Mandatory)][string]$JobTitle,
    [string]$UsageLocation = 'AU',
    [string]$LicenseSku = 'SPB',
    [string]$TicketRef = 'N/A'
)

$ErrorActionPreference = 'Stop'

function New-TempPassword {
    $sets = @('abcdefghijkmnpqrstuvwxyz','ABCDEFGHJKLMNPQRSTUVWXYZ','23456789','!@#$%&*')
    $all  = ($sets -join '').ToCharArray()
    $pick = { param($chars) $chars[[System.Security.Cryptography.RandomNumberGenerator]::GetInt32($chars.Length)] }
    $chars = @()
    foreach ($s in $sets) { $chars += & $pick $s.ToCharArray() }   # one from each set
    1..12 | ForEach-Object { $chars += & $pick $all }
    -join ($chars | Sort-Object { [System.Security.Cryptography.RandomNumberGenerator]::GetInt32(1000) })
}

if (-not (Get-MgContext)) { throw "Not connected. Run Connect-MgGraph first." }

$domain = (Get-MgDomain | Where-Object IsDefault).Id
$upn    = ("{0}.{1}@{2}" -f $GivenName, $Surname, $domain).ToLower()

if (Get-MgUser -Filter "userPrincipalName eq '$upn'" -ErrorAction SilentlyContinue) {
    throw "User $upn already exists."
}

$sku = Get-MgSubscribedSku -All | Where-Object SkuPartNumber -eq $LicenseSku
if (-not $sku) { throw "Licence SKU '$LicenseSku' not found in this tenant." }
if (($sku.PrepaidUnits.Enabled - $sku.ConsumedUnits) -lt 1) { throw "No free '$LicenseSku' licences left." }

$password = New-TempPassword

if ($PSCmdlet.ShouldProcess($upn, "Create user, set usage location, assign $LicenseSku")) {
    $user = New-MgUser -AccountEnabled `
        -DisplayName "$GivenName $Surname" -GivenName $GivenName -Surname $Surname `
        -UserPrincipalName $upn -MailNickname ("{0}.{1}" -f $GivenName, $Surname).ToLower() `
        -Department $Department -JobTitle $JobTitle -UsageLocation $UsageLocation `
        -PasswordProfile @{ Password = $password; ForceChangePasswordNextSignIn = $true }

    Set-MgUserLicense -UserId $user.Id -AddLicenses @(@{ SkuId = $sku.SkuId }) -RemoveLicenses @() | Out-Null

    [pscustomobject]@{
        Timestamp = (Get-Date).ToString('s'); Action = 'Starter'; UPN = $upn
        Department = $Department; Ticket = $TicketRef; By = (Get-MgContext).Account
    } | Export-Csv -Path (Join-Path $PSScriptRoot '../logs/actions.csv') -Append -NoTypeInformation

    Write-Host "Created $upn" -ForegroundColor Green
    Write-Host "Temporary password (shown once, give to the user securely): $password"
    Write-Host "Dynamic group '$Department' membership can take a few minutes to update."
}