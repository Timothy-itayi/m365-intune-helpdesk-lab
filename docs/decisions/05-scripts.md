# Decisions: Scripts

Previous: [04-groups.md](04-groups.md)

Phase note: [03-scripts.md](../phases/03-scripts.md)

Evidence: [evidence/03-scripts](../../evidence/03-scripts/00-connect-mggraph.md)

## Decisions

- Signed in to Microsoft Graph with device code authentication (`-UseDeviceAuthentication`), because the container has no browser. The sign-in happens in the Mac's browser.
- Signed in as the admin account, not the break-glass account, so the break-glass account stays out of routine use.
- Requested six delegated scopes: `User.ReadWrite.All`, `Group.ReadWrite.All`, `Directory.Read.All`, `Organization.Read.All`, `LicenseAssignment.ReadWrite.All` and `AuditLog.Read.All`. Consented on behalf of the organisation so the app does not prompt per user.
- Built every script on `-WhatIf` support, and ran a dry run before creating any user.
- Built the user address from the tenant's default domain (`Get-MgDomain`) instead of hardcoding it, so the scripts work in any tenant.
- Defaulted the licence to `SPB` (Microsoft 365 Business Premium) and the usage location to `AU`. Both can be overridden with parameters.
- Print the temporary password once and never write it to the log. New users must change it at first sign-in.
- Logged every joiner and leaver to `logs/actions.csv` with a ticket reference and the admin who ran it. The log is gitignored.
- Offboard leavers by setting `department` to `Leaver`, so the dynamic groups drop them. This is how the leaver process works around dynamic groups not being editable by hand ([04-groups.md](04-groups.md)). The script also blocks sign-in, revokes sessions, removes licences and removes the user from every assigned group, including Microsoft 365 groups. It was run for Ben Carter, and it also removed him from the `Itayi` group ([07-leaver-output.md](../../evidence/03-scripts/07-leaver-output.md)).
- Made the leaver script ask for confirmation (`ConfirmImpact = High`), so a real offboarding needs a deliberate answer after the dry run.
- Kept the tenant report as a read-only CSV export in `logs/tenant-report.csv`, gitignored, with a `StaleOrNever` flag from the sign-in date ([09-tenant-report.md](../../evidence/03-scripts/09-tenant-report.md)).
- Left `SG-All-Staff` as a manual step. `New-Starter.ps1` does not add users to it.
- Gave the helpdesk technician account the Helpdesk Administrator role, not Global Administrator, and tested it. It could reset a standard user's password but could not create users ([06-helpdesk-role-test.md](../../evidence/03-scripts/06-helpdesk-role-test.md)).

## Trade-offs

- The tenant-wide consent gives the Microsoft Graph Command Line Tools app write access to all users, groups and licences. That is broad for a lab, and too broad for production.
- Printing the password to the terminal means it can end up in scrollback or in screenshots. The unredacted screenshot from this phase was kept out of the repo for that reason.
- The scripts write the log after creating the user. If `logs/` is missing, the user exists but the run fails before the password is printed. See [scripts/README.md](../../scripts/README.md).
- The helpdesk account and its password reset were done in the portal, so they are not in `logs/actions.csv`. The log only covers what the scripts do.
- `-TicketRef` is free text with no validation. Farid's starter was logged as `INC-000` instead of `INC-0001`, and the log is append-only, so the typo stays.
- The leaver script removes a user from every assigned group. That is broader than the expected output, which only listed `SG-All-Staff`. It is right for a leaver, but it would also strip a user from a group they should keep.
- The private-window sign-in test for Ben showed "Your account or password is incorrect". The sign-in error alone cannot tell a blocked account from a wrong password. The admin center status is the real proof ([08-ben-blocked.md](../../evidence/03-scripts/08-ben-blocked.md)).
- The tenant report showed "never signed in" for accounts that had signed in, so `StaleOrNever` cannot be trusted yet.
