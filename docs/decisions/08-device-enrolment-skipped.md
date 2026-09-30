# Decisions: Device enrolment skipped

Previous: [07-intune.md](07-intune.md)

Phase note: [06-device.md](../phases/06-device.md)

## Decisions

- Skipped Phase 6 (enrol a Windows device). There is no Windows machine to use, and Docker on macOS cannot run a Windows desktop. The tutorial lists skipping as acceptable, provided the README says clearly that device enrolment was not tested and why.
- Did not try a Windows VM or a cloud VM. Only the decision to skip is recorded here. Whether those routes would have worked was not checked.
- Kept CA03 in Report-only permanently ([06-conditional-access.md](06-conditional-access.md)).
- Dropped INC-0006 (device non-compliant) from the incident list. It needs an enrolled device.

## Trade-offs

- Every Phase 5 policy is configuration only. Compliance, the config profile, the update ring, the app install and automatic enrolment were never run, so none of them is shown to work.
- CA03 is a policy that can never be switched on safely in this lab. Its Report-only state is the final state, not a stage.
- The per-setting compliance failures, such as BitLocker without a TPM, that the tutorial expects would have been the most useful evidence in this phase. They don't exist.
- For interviews, this phase is a gap. The honest answer is that the policies were designed and assigned but never tested on a device.
