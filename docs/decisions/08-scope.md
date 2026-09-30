# Decisions: Scope

Previous: [07-intune.md](07-intune.md)

## Decisions

- Focus the lab on Phases 1 to 5, the Microsoft 365 side: tenant, groups, PowerShell automation, MFA and Conditional Access, and Intune policies.
- Do not build Phase 7 (tickets, incident write-ups, runbooks) or Phase 8 (portfolio polish) out. Ticketing was covered in a prior project. The repo keeps the two setup incident reports, six runbooks written from the steps run in the lab, not from incidents ([README.md](../runbooks/README.md)) and one sample ticket ([osticket-452109.md](../../tickets/osticket-452109.md)).
- Treat the tenant as temporary. It is being torn down, so the screenshots and write-ups are the record.
- Treat the users as fictional. Because of that, tidying details such as blurring an IP address in a screenshot is a low priority.

## Trade-offs

- The one sample ticket has a resolution note copied from the tutorial's MFA example, which doesn't match what happened to Ben's account. It is documented as a staged example, not a real incident. Nothing else here shows troubleshooting from a user's report, and the Phase 3 leaver run is the closest real thing.
- Once the tenant is gone, evidence gaps cannot be filled. The open gaps are listed in the phase notes ([04-conditional-access.md](../phases/04-conditional-access.md), [05-intune.md](../phases/05-intune.md)).
- The sample runbook was written from a normal sign-in, not an incident, so it is untested.
