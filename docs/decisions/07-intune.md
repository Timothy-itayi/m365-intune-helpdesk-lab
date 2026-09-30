# Decisions: Intune

Previous: [06-conditional-access.md](06-conditional-access.md)

Phase note: [05-intune.md](../phases/05-intune.md)

Evidence: [evidence/05-intune](../../evidence/05-intune/00-mdm-user-scope.md)

## Decisions

- Set the MDM user scope to All, so any user's device that joins Entra can enrol in Intune. The alternative was Some, scoped to `SG-All-Staff` ([00-mdm-user-scope.md](../../evidence/05-intune/00-mdm-user-scope.md)).
- Created four policies and targeted each at `SG-All-Staff`:
  - `Win-Compliance-Baseline`, a Windows compliance policy that marks a noncompliant device immediately ([01-compliance-policy.md](../../evidence/05-intune/01-compliance-policy.md)).
  - `Win-Config-Baseline`, a settings catalog profile with a 900-second machine inactivity limit ([02-config-profile.md](../../evidence/05-intune/02-config-profile.md)).
  - `Win-Updates-Standard`, an update ring with a 3-day quality update deferral and a 5-day feature update deferral ([03-update-ring.md](../../evidence/05-intune/03-update-ring.md)).
  - Windows Terminal, a Microsoft Store app assigned as Required, installing for the user ([04-app-assignment.md](../../evidence/05-intune/04-app-assignment.md)).
- Used one group, `SG-All-Staff`, for every assignment. It is the same group CA03 targets ([06-conditional-access.md](06-conditional-access.md)), so compliance and access policy use one scope.

## Trade-offs

- MDM scope All reaches every user's devices, including admins. Scoping to `SG-All-Staff` would narrow that. `SG-All-Staff` is maintained by hand ([05-scripts.md](05-scripts.md)), so a new starter who isn't added gets the enrolment scope but none of the policies.
- In production the policies would be piloted on a small group before targeting all staff.
- Portal changes are not in `logs/actions.csv`. The evidence and this log are the record.
