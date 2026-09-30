# Runbook: Reset a user's password

Previous: [leaver.md](leaver.md)

**Applies to:** Standard users, by a Helpdesk Administrator  |  **Status:** Written from the steps run in the lab, not from an incident  |  **Last run:** 2026-09-29, reset of Ava Nguyen's password ([06-helpdesk-role-test.md](../../evidence/03-scripts/06-helpdesk-role-test.md))

## Symptoms

A user forgot their password or is locked out, and can't sign in.

## Checks (in order)

1. Verify the user's identity using the company's process, such as a call-back to the number on file or manager approval.
2. Confirm the account is enabled. If the sign-in is blocked, find out why before resetting. A leaver's blocked account should stay blocked ([leaver.md](leaver.md)).
3. Sign in as the helpdesk technician, not as the admin or break-glass account. The role needs only Helpdesk Administrator.

## Fix

1. Microsoft 365 admin center > Users > Active users.
2. Select the user and choose **Reset password**.
3. Give the new password to the user through a secure channel.

![Password reset confirmation](../../evidence/03-scripts/images/helpdesk-password-reset.png)

## Verify it worked

The admin center shows "Password has been reset" for the user. Ask the user to sign in. The first sign-in with the new password was not shown in the lab.

## Escalate when

- Identity can't be verified.
- The account is privileged. Resetting a privileged account's password was not tested with the Helpdesk Administrator role.
- The user can sign in but not complete MFA. See [mfa-re-registration.md](mfa-re-registration.md).

## Notes

- The same role cannot create users: there's no "Add a user" button, and the Create button in Entra is disabled ([helpdesk-create-user-denied.png](../../evidence/03-scripts/images/helpdesk-create-user-denied.png)).
- Portal actions aren't in `logs/actions.csv`, so record the reset on the ticket.

## Related tickets

None.
