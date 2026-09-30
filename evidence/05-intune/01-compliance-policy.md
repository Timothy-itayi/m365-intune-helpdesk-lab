# 5.2 Compliance Policy

Previous: [00-mdm-user-scope.md](00-mdm-user-scope.md)

Decision: [07-intune.md](../../docs/decisions/07-intune.md)

## Steps

Intune admin center (`intune.microsoft.com`) > Devices > Compliance > Create policy > Windows 10 and later.

| Setting | Value |
| --- | --- |
| Name | `Win-Compliance-Baseline` |
| Device Health | Require BitLocker, require Secure Boot |
| System Security | Require a password to unlock, minimum length 8. Firewall: Require. Antivirus: Require |
| Actions for noncompliance | Mark device noncompliant, immediately |
| Assignments | `SG-All-Staff` |

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

## What this proves, and what it doesn't

- The policy exists and is assigned to `SG-All-Staff`, with the noncompliance action set to Immediately.
- **BitLocker, Secure Boot and Firewall are still not visible.** The properties page shows Antivirus, the password requirement and the minimum length. The settings page has Device Health collapsed and shows only Password. Expand Device Health (BitLocker, Secure Boot) and the firewall setting to show them.
- The settings page shows three password values the tutorial didn't ask for: a 1-minute inactivity limit, 41-day expiry and 5 remembered passwords. I don't know whether they were chosen or are defaults. A 1-minute inactivity limit is strict for a password requirement.
- The "unlock mobile devices" label is Intune's wording for the password requirement. This policy is for Windows.
- No device is enrolled, so nothing has been evaluated against this policy yet.
