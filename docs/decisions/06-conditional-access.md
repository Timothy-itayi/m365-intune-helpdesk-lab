# Decisions: Conditional Access

Previous: [05-scripts.md](05-scripts.md)

Phase note: [04-conditional-access.md](../phases/04-conditional-access.md)

Evidence: [evidence/04-conditional-access](../../evidence/04-conditional-access/00-security-defaults-off.md)

## Decisions

- Disabled security defaults, choosing "My organization is planning to use Conditional Access". Conditional Access policies cannot be created while security defaults are on, and the two are not meant to run together ([00-security-defaults-off.md](../../evidence/04-conditional-access/00-security-defaults-off.md)).
- Created every policy in Report-only. Report-only records what would have happened without enforcing it, so a mistake cannot lock the tenant out while the policies are being tested.
- Created three policies ([01-ca01-settings.md](../../evidence/04-conditional-access/01-ca01-settings.md), [02-policy-list-report-only.md](../../evidence/04-conditional-access/02-policy-list-report-only.md)):
  - `CA01 Require MFA - All users`: all users, all cloud apps, require MFA.
  - `CA02 Block legacy authentication`: all users, Exchange ActiveSync and other legacy clients, block access.
  - `CA03 Require compliant device - Office 365`: `SG-All-Staff` only, Office 365, require a compliant device.
- Excluded the break-glass account from CA01. This is the exclusion promised in [03-tenant.md](03-tenant.md). CA02 and CA03 are meant to exclude it too, but their settings are not shown in a screenshot.
- Left CA03 in Report-only. The plan was to wait for Phase 6, but it was skipped ([08-device-enrolment-skipped.md](08-device-enrolment-skipped.md)). No device is enrolled in Intune, so requiring a compliant device would block every user in `SG-All-Staff`.
- Scoped CA03 to the `SG-All-Staff` group, excluding break-glass and the admin, rather than to all users. The tutorial gives no reason, and this scope is not shown in a screenshot.

- Tested with Ava Nguyen, a standard user, in a private browser window, and registered Microsoft Authenticator for her. The check is her sign-in log entry ([03-ava-mfa-prompt.md](../../evidence/04-conditional-access/03-ava-mfa-prompt.md), [04-signin-log-ca-tab.md](../../evidence/04-conditional-access/04-signin-log-ca-tab.md)).
- The plan is to switch CA01 and CA02 to On only after Ava's sign-in shows the policy working and the admin has MFA registered. **Not done, or not shown yet.** The last policy list screenshot shows all three Report-only.

## Trade-offs

- Ava's sign-in log shows an Enabled MFA policy named "Require multifactor authentication for all users", which is not CA01's name. The MFA prompt cannot be attributed to CA01, so the test has not shown that CA01 works. See [04-signin-log-ca-tab.md](../../evidence/04-conditional-access/04-signin-log-ca-tab.md).
- The sign-in log screenshot shows Ava's IP address and suburb. It was left as is in the repo.

- Security defaults gave every user an MFA prompt with no setup. Turning them off and replacing them with report-only policies means the tenant has less MFA enforcement of its own until CA01 is switched to On. The Microsoft-managed policies (below) may fill part of that gap.
- The tenant already has four Microsoft-managed Conditional Access policies in the On state: Block legacy authentication, MFA for Azure Management, MFA for admins and MFA for all users. They exist alongside CA01 and CA02, so the new policies partly duplicate them. I don't know whether they exclude the break-glass account, and I have not opened them. This needs checking before the break-glass account is relied on.
- CA01 excludes only the break-glass account. The tutorial suggests also excluding the admin until MFA is confirmed working. That is harmless in Report-only, but it must be settled before CA01 is switched to On.
- An account excluded from every policy is also an account with no MFA. The break-glass account's protection is a long password in a password manager and monitoring its sign-ins, which is not yet set up ([01-tenant.md](../phases/01-tenant.md)).
- The action log (`logs/actions.csv`) only covers what the scripts do. Portal changes such as these policies are recorded in the evidence and this decision log, not in the action log.
- The saved state of security defaults is inferred, not shown, because the screenshot was taken before pressing Save.
