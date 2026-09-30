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

## What this proves, and what it doesn't

- The policy exists and is assigned to `SG-All-Staff`, with the noncompliance action set to Immediately.
- **BitLocker, Secure Boot and Firewall are not visible in the screenshot.** Only Antivirus, the password requirement and the minimum length appear. Either the screenshot is cropped, or those settings were not added. It doesn't show which. Scroll the properties page and capture the Device Health and Firewall sections.
- The "unlock mobile devices" label is Intune's wording for the password requirement. This policy is for Windows.
- No device is enrolled, so nothing has been evaluated against this policy yet.
