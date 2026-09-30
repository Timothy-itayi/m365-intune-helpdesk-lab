# 4.2 Policy CA01: Require MFA for All Users

Previous: [00-security-defaults-off.md](00-security-defaults-off.md)

Decision: [06-conditional-access.md](../../docs/decisions/06-conditional-access.md)

## Steps

Entra admin center > Protection > Conditional Access > Policies > New policy.

| Setting | Value |
| --- | --- |
| Name | `CA01 Require MFA - All users` |
| Users | Include All users. Exclude the break-glass account (and your own admin until MFA is confirmed working) |
| Target resources | All cloud apps |
| Grant | Require multifactor authentication |
| Enable policy | Report-only |

## Evidence

![CA01 settings](images/ca-01-settings.png)

What the screenshot shows:

- **Name:** `CA01 Require MFA - All users`.
- **Users:** "All users included and specific users excluded". The Exclude tab lists 1 user, Break Glass (`breakglass@helpdeskco123.onmicrosoft.com`, truncated).
- **Target resources:** "All resources (formerly 'All cloud apps')". The portal has renamed the option the tutorial calls All cloud apps.
- **Grant:** "1 control selected".
- **Enable policy:** Report-only.

## What this proves, and what it doesn't

- The break-glass exclusion is shown, as the Phase 1 decision said it would be ([03-tenant.md](../../docs/decisions/03-tenant.md)).
- The admin account is not excluded. The exclusion list holds 1 user, and it is Break Glass. The tutorial suggests excluding the admin too until MFA is confirmed working. That is safe while the policy is report-only, but it needs a decision before the policy is switched to On. [Phase 1](../01-tenant/00-Secure-first-admin.md) records enabling MFA on the admin, though that phase has no screenshot of the MFA result.
- The Grant panel is not open. "1 control selected" does not say which control it is, so this screenshot does not prove it is Require multifactor authentication.
- Conditions shows "0 conditions selected", which is expected for this policy.
