# Phase 6: Enrol a Windows device (skipped)

Previous: [05-intune.md](05-intune.md)

Decisions: [08-device-enrolment-skipped.md](../decisions/08-device-enrolment-skipped.md)

Status: Skipped. No device was enrolled and there is no evidence for this phase.

## Why

There is no Windows machine to use. The lab runs on a Mac, and Docker cannot run a Windows desktop. Joining Entra ID also needs Windows 11 Pro, Enterprise or Education, because Windows Home cannot join. The other routes in the tutorial (a Windows VM on the Mac, a VM on another machine, a cloud VM) were not pursued.

## What was not done

- 6.1: Join a device to Entra ID, see it in Intune with a primary user, and check its per-setting compliance.
- 6.2: Switch CA03 to On and test a compliant device against an unmanaged browser session.
- 6.3: Device findings, including which policies applied and which failed.
- INC-0006 (device non-compliant), which depends on an enrolled device.

## What this leaves untested

| Item | State |
|---|---|
| Automatic MDM enrolment (MDM user scope All, [Phase 5](05-intune.md)) | Configured, never triggered |
| `Win-Compliance-Baseline` | Configured, never evaluated against a device |
| `Win-Config-Baseline` | Configured, never applied |
| `Win-Updates-Standard` | Configured, never applied |
| Windows Terminal assignment | Configured, never installed |
| CA03 Require compliant device | Report-only, never enforced |

All of the Intune work in Phase 5 is configuration only. Nothing shows it working on a device.

## Consequences

- **CA03 must stay in Report-only.** No device can be compliant, so switching CA03 to On would block every user in `SG-All-Staff`.
- No compliance failures or device findings exist to write up. The tutorial rates those as the most valuable content of this phase, and they are missing.
- The Phase 5 checkpoint is weaker than the tutorial intended, because nothing was verified on a device.

## If this is picked up later

Any of the routes in the tutorial would do. On Apple silicon a Windows VM needs an ARM build of Windows, and the tutorial says to check the current guide first. Then follow steps 6.1 to 6.3, put the evidence in `evidence/06-device/`, and update this note and the decision log.

## Checkpoint

Phase 6 is skipped. The README states that device enrolment was not tested and why.
