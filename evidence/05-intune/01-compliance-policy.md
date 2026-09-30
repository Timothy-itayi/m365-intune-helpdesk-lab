# 5.2 Compliance Policy

Previous: [00-mdm-user-scope.md](00-mdm-user-scope.md)

Decision: [07-intune.md](../../docs/decisions/07-intune.md)

## Steps

Intune admin center (`intune.microsoft.com`) > Devices > Compliance > Create policy > Windows 10 and later.

Configure Device Health, System Security (password, firewall, antivirus) and the actions for noncompliance, then assign the policy to `SG-All-Staff`. Name: `Win-Compliance-Baseline`.

## Evidence

![Win-Compliance-Baseline properties](images/compliance-policy.png)

The saved policy's properties page shows:

| Item | Value |
| --- | --- |
| Policy | Win-Compliance-Baseline, Windows 10 and later |
| Antivirus | Required |
| Require a password to unlock mobile devices | Required |
| Minimum password length | 8 |
| Action for noncompliance | Mark device noncompliant, Immediately, no additional recipients |
| Scope tags | Default |
| Included group | `SG-All-Staff`, Active, no filter |
| Excluded groups | None |

The policy's settings page (step 1 of 2, Compliance settings) with System Security > Password expanded:

![Win-Compliance-Baseline password settings](images/compliance-password-settings.png)

| Password setting | Value |
| --- | --- |
| Require a password to unlock mobile devices | Require |
| Simple passwords | Not configured |
| Password type | Device default |
| Minimum password length | 8 |
| Maximum minutes of inactivity before password is required | 1 minute |
| Password expiration (days) | 41 |
| Number of previous passwords to prevent reuse | 5 |
| Require password when device returns from idle state | Not configured |

Custom Compliance, Device Health, Device Properties and Configuration Manager Compliance are collapsed in this view.

## Result

The policy exists, targets `SG-All-Staff` and marks a noncompliant device immediately.
