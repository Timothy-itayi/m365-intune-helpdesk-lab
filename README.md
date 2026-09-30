# m365-intune-helpdesk-lab

A small-business IT environment run the way a service desk or MSP runs one, built on a Microsoft 365 trial tenant. The focus is the Microsoft 365 side: tenant setup, users and dynamic groups, MFA and Conditional Access, Intune policies, and PowerShell automation for joiners and leavers.

Setup: MacBook + Docker Desktop.

## Scope

- **In scope:** Phases 1 to 5, plus the Docker and PowerShell setup.
- **Phase 6 (device enrolment) was skipped.** No Windows machine was available.
- **Tickets, incident write-ups and runbooks are not the focus here.** Ticketing was covered in a prior project. The only incident reports in this repo are the two from the setup ([docs/incidents](docs/incidents/00-setup.md)), six runbooks written from the lab's steps, and one sample ticket ([tickets/osticket-452109.md](tickets/osticket-452109.md)).
- **The tenant is a temporary lab and is being torn down.** The users are fictional. The screenshots and write-ups are the record, not a live environment.

## Documentation

| Section | What's in it |
| --- | --- |
| [docs/phases](docs/phases/01-tenant.md) | One note per phase: objective, what was done, evidence, limits |
| [docs/decisions](docs/decisions/README.md) | Why things were built the way they were, numbered in order |
| [docs/incidents](docs/incidents/00-setup.md) | Incident reports: what broke, root cause, resolution, lessons learned |
| [docs/runbooks](docs/runbooks/README.md) | Step-by-step fixes for common faults, written from the lab's steps |
| [docs/worklog](docs/worklog/setup-00.md) | Session-by-session log of what was done and learned |
| [evidence](evidence/00-setup/00.md) | Step-by-step write-ups with screenshots, one folder per phase |

Each numbered file links to the one before it, so the trail reads in order from `00`.

## Phases

| Phase | Status | Note | Evidence | Decisions |
| --- | --- | --- | --- | --- |
| Setup | Done | [worklog](docs/worklog/setup-00.md) | [00-setup](evidence/00-setup/00.md) | [00.md](docs/decisions/00.md), [02-setup.md](docs/decisions/02-setup.md) |
| 1: Tenant | Written up | [01-tenant.md](docs/phases/01-tenant.md) | [01-tenant](evidence/01-tenant/00-Secure-first-admin.md) | [03-tenant.md](docs/decisions/03-tenant.md) |
| 2: Groups | Written up | [02-groups.md](docs/phases/02-groups.md) | [02-groups](evidence/02-groups/00-dg-sales-rule.md) | [04-groups.md](docs/decisions/04-groups.md) |
| 3: Scripts | Written up | [03-scripts.md](docs/phases/03-scripts.md), [scripts/](scripts/README.md) | [03-scripts](evidence/03-scripts/00-connect-mggraph.md) | [05-scripts.md](docs/decisions/05-scripts.md) |
| 4: Conditional Access | In progress (4.1-4.3; enforcement not shown) | [04-conditional-access.md](docs/phases/04-conditional-access.md) | [04-conditional-access](evidence/04-conditional-access/00-security-defaults-off.md) | [06-conditional-access.md](docs/decisions/06-conditional-access.md) |
| 5: Intune | Configured, with gaps | [05-intune.md](docs/phases/05-intune.md) | [05-intune](evidence/05-intune/00-mdm-user-scope.md) | [07-intune.md](docs/decisions/07-intune.md) |
| 6: Device | Skipped (no Windows machine) | [06-device.md](docs/phases/06-device.md) | None | [08-device-enrolment-skipped.md](docs/decisions/08-device-enrolment-skipped.md) |
| 7: Incidents | Out of scope (ticketing was done in a prior project). Setup incidents only | [00-setup.md](docs/incidents/00-setup.md), [01-setup.md](docs/incidents/01-setup.md) | Screenshots in [00-setup](evidence/00-setup/00.md) and [01](evidence/00-setup/01.md) | Linked from each report |

### Setup trail

| Step | Evidence | Decision | Incident |
| --- | --- | --- | --- |
| 00: osTicket and MariaDB | [00.md](evidence/00-setup/00.md) | [00.md](docs/decisions/00.md) | [00-setup.md](docs/incidents/00-setup.md) |
| 01: PowerShell Docker image | [01.md](evidence/00-setup/01.md) | [02-setup.md](docs/decisions/02-setup.md) | [01-setup.md](docs/incidents/01-setup.md) |

## What was not tested

- **Device enrolment (Phase 6) was skipped.** There is no Windows machine to use, and Docker on macOS cannot run a Windows desktop. No device was enrolled in Intune.
- Because of that, the Intune policies from Phase 5 (compliance, configuration, update ring, Windows Terminal app) are configuration only. None has been applied to or evaluated against a device, and automatic enrolment was never triggered.
- CA03 (require compliant device) stays in Report-only, and has to, because no device can be compliant.
- The device non-compliant incident (INC-0006) was dropped for the same reason, and no other Phase 7 incidents, tickets or runbooks were done. The one sample ticket is a staged example. See [Scope](#scope).
- Phase 4 enforcement of CA01 and CA02 is also not shown in the evidence ([04-conditional-access.md](docs/phases/04-conditional-access.md)).

## Running PowerShell

PowerShell runs in a container, not on macOS. Build the image once, then enter it from the repo root:

```bash
docker build --progress=plain -t m365-helpdesk-pwsh .
docker run --rm -it -v "$PWD":/work m365-helpdesk-pwsh pwsh
```

Type `exit` to leave the container. Closing it drops the Microsoft Graph session, so reconnect with the steps in [scripts/README.md](scripts/README.md).

Details and verification: [evidence/00-setup/01.md](evidence/00-setup/01.md)

## Repository layout

```text
docs/         phases, decisions, incidents, worklog
evidence/     one folder per phase, with step write-ups and images/
scripts/      PowerShell automation: New-Starter, Remove-Leaver, Get-TenantReport
tickets/      one sample osTicket record
Dockerfile    PowerShell + Microsoft Graph image (arm64)
```

`evidence-raw/` and `logs/` are local only and gitignored.
