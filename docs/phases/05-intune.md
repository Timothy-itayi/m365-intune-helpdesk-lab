# Phase 5: Intune policies

Previous: [04-conditional-access.md](04-conditional-access.md)

Decisions: [07-intune.md](../decisions/07-intune.md)

Status: Configured, with gaps. The policies were built and assigned to `SG-All-Staff`, but three screenshots are pre-Create pages, and three settings in them don't match the plan.

## Objective

Define a baseline for company Windows devices.

## Policies

| Policy | Type | Key settings (as shown in evidence) | Assigned to (as shown) |
|---|---|---|---|
| Win-Compliance-Baseline | Compliance | Antivirus, password required, minimum length 8. BitLocker, Secure Boot and firewall not visible | SG-All-Staff |
| Win-Config-Baseline | Settings catalog | Consumer features **Allow**, Spotlight Allow. Inactivity limit not visible | Not shown (empty) |
| Win-Updates-Standard | Update ring | 3-day quality deferral, 5-day feature deferral, no deadline set | Not shown |
| Windows Terminal | App | Required, install behaviour User | SG-All-Staff |

The intended settings were BitLocker, Secure Boot, a password of 8+ characters, firewall and antivirus; a 15-minute inactivity lock and consumer features off; a 3-day quality deferral and a 5-day deadline.

## Why these settings

- **Compliance baseline:** disk encryption, boot integrity, a password, a firewall and antivirus are the minimum for a company laptop, and a device that lacks them is marked noncompliant straight away.
- **Inactivity lock:** an unattended, unlocked machine is an easy target. 900 seconds is 15 minutes.
- **Consumer features off:** stops Windows installing and suggesting consumer apps on a work device.
- **Update ring:** deferring quality updates a few days lets a bad update show up elsewhere before it reaches staff, and a deadline forces the install.
- **Windows Terminal:** a small, free app that proves app deployment works.

These are the reasons for the settings. Some of these settings are not confirmed in the screenshots, as listed below.

## Evidence

1. [MDM user scope](../../evidence/05-intune/00-mdm-user-scope.md)
2. [Compliance policy](../../evidence/05-intune/01-compliance-policy.md)
3. [Configuration profile](../../evidence/05-intune/02-config-profile.md)
4. [Update ring](../../evidence/05-intune/03-update-ring.md)
5. [App assignment](../../evidence/05-intune/04-app-assignment.md)

- ![MDM user scope](../../evidence/05-intune/images/mdm-user-scope.png)
- ![Compliance policy](../../evidence/05-intune/images/compliance-policy.png)
- ![Config profile](../../evidence/05-intune/images/config-profile.png)
- ![Update ring](../../evidence/05-intune/images/update-ring.png)
- ![App assignment](../../evidence/05-intune/images/app-assignment.png)

## Results

- MDM user scope shows All, before Save ([00-mdm-user-scope.md](../../evidence/05-intune/00-mdm-user-scope.md)).
- The compliance policy is saved and assigned to `SG-All-Staff`, with "Mark device noncompliant, immediately" as its action.
- The config profile, update ring and app are shown on the Review + create page, before Create.
- The app is Required for `SG-All-Staff`.

## Issues and open questions

| Issue | Cause | Status |
|---|---|---|
| Config profile shows Allow Windows Consumer Features = Allow | Setting not turned off, or the wrong value picked | Open. Fix the setting, or note that it was left on |
| Config profile shows no group in Included groups | Assignment not captured, or not set | Open. Check Properties > Assignments on the created profile |
| Machine inactivity limit (900 s) not visible | It is in a collapsed section | Open. Expand it and screenshot |
| Update ring: 5 days is the feature update deferral, deadline settings are Not configured | Plan asked for a deadline | Open. Set a deadline or change the plan |
| Update ring assignment not shown | Review page has no visible assignment | Open |
| Compliance policy: BitLocker, Secure Boot and Firewall not visible | Cropped screenshot, or not added | Open. Scroll the properties page |
| MDM scope, config profile, update ring and app screenshots are pre-Save/Create | Screenshots taken on the last wizard page | Open. Re-open the objects after creating them |
## Risks I'm managing

- **Break-glass account in use.** The screenshots show `breakglass@helpdeskco…` signed in. Reason: the break-glass account is used to read the Entra sign-in logs while checking the Conditional Access results in [Phase 4](04-conditional-access.md), and the Intune pages were captured in the same session. The account has no MFA policy of its own, so its sign-ins should still be watched.
- MDM scope All means every user can enrol, not only staff in `SG-All-Staff`.

## Not yet tested

Policies were created but not verified on a device until Phase 6. No device is enrolled.

## Checkpoint

The tutorial's checkpoint is "four assignments visible in Intune". Two are shown as assigned (the compliance policy and the app), and only one of those, the compliance policy, is a saved object. The config profile's assignment list is empty, and the update ring's assignment is not shown. The checkpoint is not met by the evidence yet.
