# Phase 4: MFA and Conditional Access

Previous: [03-scripts.md](03-scripts.md)

Decisions: [06-conditional-access.md](../decisions/06-conditional-access.md)

## Objective

Replace security defaults with Conditional Access policies that require MFA and block weak sign-in methods, introduced in report-only mode so nothing can lock the tenant out.

## Policies

| Policy | Applies to | Control | State |
|---|---|---|---|
| CA01 Require MFA - All users | All users, excluding the break-glass account | Require multifactor authentication | Report-only |
| CA02 Block legacy authentication | All users | Block Exchange ActiveSync and other legacy clients | Report-only |
| CA03 Require compliant device - Office 365 | `SG-All-Staff` | Require a compliant device | Report-only |

## Method

- Disabled security defaults and chose to replace them with Conditional Access.
- Built the three policies in report-only mode, so each records what it would have done without enforcing it.
- Excluded the break-glass account from CA01.
- Signed in as a standard user, Ava Nguyen, in a private window. She registered Microsoft Authenticator and completed a number-matching MFA challenge.
- Opened her sign-in in the Entra sign-in logs and read the Conditional Access policy details.

## Design choices

- **Security defaults off first.** Conditional Access replaces them, and the two can't be used together.
- **Report-only first.** It is the safe way to introduce a policy that affects every user.
- **Break-glass excluded from the MFA policy.** The account exists to get back in if a policy locks everyone out ([Phase 1](01-tenant.md)).
- **Compliance policy scoped to `SG-All-Staff`.** The group that Intune policies target in [Phase 5](05-intune.md).

## Results

- Security defaults replaced by three Conditional Access policies, all Report-only ([02-policy-list-report-only.md](../../evidence/04-conditional-access/02-policy-list-report-only.md)).
- CA01 excludes the break-glass account ([01-ca01-settings.md](../../evidence/04-conditional-access/01-ca01-settings.md)).
- Ava was challenged for MFA with a number-matching prompt in Authenticator ([03-ava-mfa-prompt.md](../../evidence/04-conditional-access/03-ava-mfa-prompt.md)).
- Her sign-in log shows an MFA policy applied, with the result Success and the grant control satisfied ([04-signin-log-ca-tab.md](../../evidence/04-conditional-access/04-signin-log-ca-tab.md)).
- The policy list also shows four Microsoft-managed policies in the On state: Block legacy authentication, MFA for Azure Management, MFA for admins and MFA for all users.

## Evidence

1. [Security defaults off](../../evidence/04-conditional-access/00-security-defaults-off.md)
2. [CA01 settings](../../evidence/04-conditional-access/01-ca01-settings.md)
3. [Policy list, Report-only](../../evidence/04-conditional-access/02-policy-list-report-only.md)
4. [Ava's MFA prompt](../../evidence/04-conditional-access/03-ava-mfa-prompt.md)
5. [Sign-in log, policy details](../../evidence/04-conditional-access/04-signin-log-ca-tab.md)

- ![Security defaults off](../../evidence/04-conditional-access/images/security-defaults-off.png)
- ![CA01 settings](../../evidence/04-conditional-access/images/ca-01-settings.png)
- ![Policy list](../../evidence/04-conditional-access/images/policy-list-report-only.png)
- ![Ava's MFA prompt](../../evidence/04-conditional-access/images/ava-mfa-approve-prompt.png)
- ![Sign-in log policy details](../../evidence/04-conditional-access/images/ava-ca-policy-details.png)

## What I'd do in production

- Alert whenever the break-glass account signs in.
- Use named locations and risk-based policies. Risk-based policies need Entra ID P2.
- Review the Microsoft-managed policies and their exclusions alongside custom ones.
- Stage the rollout: report-only, then a pilot group, then all users.

## Checkpoint

Security defaults are replaced by three report-only Conditional Access policies, the break-glass account is excluded from the MFA policy, and a standard user registered Authenticator and completed an MFA sign-in.
