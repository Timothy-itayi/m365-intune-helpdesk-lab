# Decisions: Conditional Access

Previous: [05-scripts.md](05-scripts.md)

Phase note: [04-conditional-access.md](../phases/04-conditional-access.md)

Evidence: [evidence/04-conditional-access](../../evidence/04-conditional-access/00-security-defaults-off.md)

## Decisions

- Disabled security defaults, choosing "My organization is planning to use Conditional Access". Conditional Access policies can't be created while security defaults are on ([00-security-defaults-off.md](../../evidence/04-conditional-access/00-security-defaults-off.md)).
- Created every policy in Report-only. Report-only records what would have happened without enforcing it, so a mistake can't lock the tenant out while the policies are being assessed.
- Created three policies ([01-ca01-settings.md](../../evidence/04-conditional-access/01-ca01-settings.md), [02-policy-list-report-only.md](../../evidence/04-conditional-access/02-policy-list-report-only.md)):
  - `CA01 Require MFA - All users`: all users, all cloud apps, require MFA.
  - `CA02 Block legacy authentication`: all users, Exchange ActiveSync and other legacy clients, block access.
  - `CA03 Require compliant device - Office 365`: `SG-All-Staff`, Office 365, require a compliant device.
- Excluded the break-glass account from CA01, as planned in [03-tenant.md](03-tenant.md).
- Kept CA03 in Report-only. Requiring a compliant device needs enrolled devices, and with none enrolled it would block every user in `SG-All-Staff`.
- Tested with Ava Nguyen, a standard user, in a private browser window. She registered Microsoft Authenticator and completed the MFA challenge ([03-ava-mfa-prompt.md](../../evidence/04-conditional-access/03-ava-mfa-prompt.md), [04-signin-log-ca-tab.md](../../evidence/04-conditional-access/04-signin-log-ca-tab.md)).

## Trade-offs

- Security defaults gave every user an MFA prompt with no setup. Replacing them with report-only policies means MFA enforcement comes from the four Microsoft-managed policies in the tenant until a custom policy is switched to On.
- Those Microsoft-managed policies (Block legacy authentication, MFA for Azure Management, MFA for admins, MFA for all users) overlap with CA01 and CA02. In production their exclusions would be reviewed next to the custom ones.
- An account excluded from every policy is also an account with no MFA. The break-glass account relies on a long password in a password manager and on monitoring its sign-ins.
- The action log (`logs/actions.csv`) covers what the scripts do. Portal changes such as these policies are recorded in the evidence and this decision log.
