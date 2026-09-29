# Phase 3: Scripts

Previous: [02-groups.md](02-groups.md)

Decisions: [05-scripts.md](../decisions/05-scripts.md)

Scripts: [scripts/README.md](../../scripts/README.md)

## Objective

Automate joiners and leavers with PowerShell and Microsoft Graph, with a dry run, a ticket reference and a log entry for every change.

## What I did

1. Entered PowerShell in the lab container and connected to Microsoft Graph with device code sign-in as the admin.
2. Confirmed the licence SKU the scripts assign (`SPB`).
3. Dry-ran `New-Starter.ps1` with `-WhatIf`.
4. Created six starters (two each in Sales, Operations and Finance) under ticket `INC-0001`.
5. Checked the users and licences in the Microsoft 365 admin center.
6. Checked that the dynamic groups filled from the department, and added the six users to `SG-All-Staff` by hand.
7. Read the action log.

## Evidence

Step write-ups, in order:

1. [Connect to Microsoft Graph](../../evidence/03-scripts/00-connect-mggraph.md)
2. [Licence SKU](../../evidence/03-scripts/01-licence-sku.md)
3. [Dry run with -WhatIf](../../evidence/03-scripts/02-whatif-dry-run.md)
4. [Create the six users](../../evidence/03-scripts/03-create-users.md)
5. [Verify in the portals](../../evidence/03-scripts/04-verify-portals.md)
6. [Actions log](../../evidence/03-scripts/05-actions-log.md)

Screenshots:

- ![Get-MgContext](../../evidence/03-scripts/images/get-mgcontext.png)
- ![Licence SKU list](../../evidence/03-scripts/images/licence-sku.png)
- ![Dry run and user creation](../../evidence/03-scripts/images/whatif-and-create-users.png)
- ![Active users](../../evidence/03-scripts/images/users-list.png)
- ![Actions log](../../evidence/03-scripts/images/actions-log.png)

Group membership evidence is in [Phase 2](02-groups.md).

## Issues and fixes

None recorded.

## What I'd do differently in production

- Deliver temporary passwords through a secure channel or a Temporary Access Pass, not the terminal.
- Grant narrower Graph permissions, and use an app registration with certificate authentication instead of a delegated admin session with tenant-wide consent.
- Create the `logs/` folder in the script if it is missing, and write the log before creating the user, or print the password first.
- Add new starters to `SG-All-Staff` in the script instead of by hand.

## Not done yet

- Farid Haddad's licence is only shown indirectly, through the 7 consumed licences in the SKU list. His row is not visible in the Active users screenshot.
- The `DG-Finance` membership is not shown in any screenshot.
- `Remove-Leaver.ps1` and `Get-TenantReport.ps1` have not been run.

## Checkpoint

You are connected to Graph, six users exist with licences, the dynamic groups filled from department, and every action is in the log.
