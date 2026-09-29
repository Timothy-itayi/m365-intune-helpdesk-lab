# Scripts

PowerShell automation for joiners, leavers and reporting. All scripts need PowerShell 7 and a Microsoft Graph connection, so they run inside the lab container, not on macOS.

## Prerequisites

Enter PowerShell from the repo root:

```bash
docker run --rm -it -v "$PWD":/work m365-helpdesk-pwsh pwsh
```

Connect at the `PS /work>` prompt, signing in as the admin (not break-glass):

```powershell
Connect-MgGraph -UseDeviceAuthentication -Scopes "User.ReadWrite.All","Group.ReadWrite.All","Directory.Read.All","Organization.Read.All","LicenseAssignment.ReadWrite.All","AuditLog.Read.All"
```

Every script stops with `Not connected` if there is no Graph session. Keep the container open while working. Closing it drops the session.

Step-by-step evidence: [evidence/03-scripts](../evidence/03-scripts/00-connect-mggraph.md)

## Scripts

| Script | Purpose | Status |
| --- | --- | --- |
| [New-Starter.ps1](New-Starter.ps1) | Create a user, set usage location, assign a licence, log the action | Run for six starters |
| [Remove-Leaver.ps1](Remove-Leaver.ps1) | Offboard a user | Not run yet |
| [Get-TenantReport.ps1](Get-TenantReport.ps1) | Export a user report and flag stale sign-ins | Not run yet |

### New-Starter.ps1

```powershell
./scripts/New-Starter.ps1 -GivenName Ava -Surname Nguyen -Department Sales -JobTitle "Account Executive" -TicketRef INC-0001 -WhatIf
```

| Parameter | Notes |
| --- | --- |
| `-GivenName`, `-Surname`, `-JobTitle` | Required |
| `-Department` | Required. `Sales`, `Operations` or `Finance`, matching the dynamic group rules |
| `-UsageLocation` | Default `AU` |
| `-LicenseSku` | Default `SPB` (Microsoft 365 Business Premium) |
| `-TicketRef` | Default `N/A` |

- The address is built from the tenant's default domain as `given.surname@domain`.
- It fails if the user already exists, the licence SKU is missing, or no licences are free.
- A random temporary password is printed once and is not logged. The user must change it at first sign-in.
- It does not add the user to `SG-All-Staff`. That is still a manual step.
- Use `-WhatIf` for a dry run first.

### Remove-Leaver.ps1

```powershell
./scripts/Remove-Leaver.ps1 -UserPrincipalName ben.carter@helpdeskco123.onmicrosoft.com -TicketRef INC-0004 -WhatIf
```

In order, it:

1. Blocks sign-in and revokes sessions.
2. Sets the department to `Leaver`, so the dynamic groups drop the user.
3. Removes all licences.
4. Removes the user from assigned groups. Dynamic groups are skipped, because they cannot be edited by hand.

It asks for confirmation by default (`ConfirmImpact = High`).

### Get-TenantReport.ps1

```powershell
./scripts/Get-TenantReport.ps1 -StaleDays 30
```

Writes `logs/tenant-report.csv` and prints a table, with stale or never-signed-in users first. Needs the `AuditLog.Read.All` scope for sign-in data.

## Action log

`New-Starter.ps1` and `Remove-Leaver.ps1` append to `logs/actions.csv`: timestamp, action, UPN, department, ticket and who ran it. The `logs/` folder is gitignored and is not created by the scripts. On a fresh clone, create it first:

```bash
mkdir -p logs
```

Otherwise the log write fails after the user has already been created.
