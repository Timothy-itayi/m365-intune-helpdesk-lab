#Requires -Version 7.0
param([int]$StaleDays = 30, [string]$OutFile = "$PSScriptRoot/../logs/tenant-report.csv")
if (-not (Get-MgContext)) { throw "Not connected. Run Connect-MgGraph first." }

$cutoff = (Get-Date).AddDays(-$StaleDays)
$report = Get-MgUser -All -Property Id,DisplayName,UserPrincipalName,Department,AccountEnabled,AssignedLicenses,SignInActivity |
  ForEach-Object {
    $last = $_.SignInActivity.LastSignInDateTime
    [pscustomobject]@{
        DisplayName  = $_.DisplayName
        UPN          = $_.UserPrincipalName
        Department   = $_.Department
        Enabled      = $_.AccountEnabled
        Licensed     = ($_.AssignedLicenses.Count -gt 0)
        LastSignIn   = $last
        StaleOrNever = (-not $last) -or ($last -lt $cutoff)
    }
  }
$report | Export-Csv -Path $OutFile -NoTypeInformation
$report | Sort-Object StaleOrNever -Descending | Format-Table -AutoSize