# Runbooks

Previous: [08-scope.md](../decisions/08-scope.md)

These runbooks follow the steps used in the lab, using the lab's own screenshots. They are not written from real incidents, because no incidents were run. Each one states its status at the top, and what was and wasn't run.

All runbooks share one layout: applies to, status, symptoms, checks, fix, verify, escalate, related tickets.

| Runbook | Based on | Status |
| --- | --- | --- |
| [mfa-re-registration.md](mfa-re-registration.md) | Phase 4 sign-in and tutorial steps | Fix steps not run |
| [new-starter.md](new-starter.md) | Phase 3, `New-Starter.ps1` | Steps run for six starters |
| [leaver.md](leaver.md) | Phase 3, `Remove-Leaver.ps1` | Steps run for one leaver |
| [password-reset.md](password-reset.md) | Phase 3, helpdesk role test | Reset run for one standard user |
| [licence-assignment-failure.md](licence-assignment-failure.md) | Phase 3, script checks | Failure not reproduced |
| [dynamic-group-missing-member.md](dynamic-group-missing-member.md) | Phase 2 groups and the leaver run | Failure not reproduced |
