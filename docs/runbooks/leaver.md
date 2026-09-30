# Runbook: Offboard a leaver

Previous: [new-starter.md](new-starter.md)

**Applies to:** Standard users  |  **Status:** Written from the steps run in the lab, not from an incident  |  **Last run:** 2026-09-29, Ben Carter ([07-leaver-output.md](../../evidence/03-scripts/07-leaver-output.md))

## Symptoms

A member of staff has left, and their access must end today.

## Checks (in order)

1. Confirm the leaver request has a ticket reference and comes from the manager or HR.
2. Connect to Graph as the admin, not the break-glass account ([scripts/README.md](../../scripts/README.md)).
3. Confirm the account exists, and note which groups and licences it has. The script removes the user from every assigned group, including Microsoft 365 groups, so check that none should be kept.

## Fix

1. Dry run. It prints one line for the whole offboarding, not the steps:

   ```powershell
   ./scripts/Remove-Leaver.ps1 -UserPrincipalName ben.carter@helpdeskco123.onmicrosoft.com -TicketRef INC-0004 -WhatIf
   ```

2. Run it without `-WhatIf` and confirm the prompt. It:
   1. blocks sign-in and revokes sessions,
   2. sets the department to `Leaver`, so the dynamic groups drop the user,
   3. removes all licences,
   4. removes the user from every assigned group.

![Leaver script output](../../evidence/03-scripts/images/leaver-scripts-ben-carter.png)

## Verify it worked

- Microsoft 365 admin center shows **Sign-in blocked** for the user:

  ![Sign-in blocked](../../evidence/03-scripts/images/admin-center-signin-blocked-ben-carter.png)

- A sign-in attempt fails with "Your account has been locked":

  ![Locked sign-in](../../evidence/03-scripts/images/ben-carter-locked-azure.png)

- After a few minutes the user is gone from the dynamic group, for example `DG-Sales`:

  ![DG-Sales after the leaver run](../../evidence/03-scripts/images/bens-removal-in-DG-Sales.png)

- `logs/actions.csv` has a `Leaver` row.

## Escalate when

- The user is a privileged account or a group owner.
- The user has devices, a mailbox or data that need handing over. The script doesn't cover them. Wiping devices in Intune and converting the mailbox to a shared mailbox were not done in this lab.
- The request doesn't come from the manager or HR.

## Notes

- A failed first run was seen with "Cannot bind argument to parameter 'UserId' because it is an empty string". The cause wasn't established.
- Dynamic group removal takes minutes, not seconds.

## Related tickets

INC-0004, the Phase 3 leaver run. A sample ticket for the same account is [osticket-452109.md](../../tickets/osticket-452109.md).
