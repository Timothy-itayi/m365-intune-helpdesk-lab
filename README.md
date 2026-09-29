# m365-intune-helpdesk-lab

A small-business IT environment run the way a service desk or MSP runs one: a Microsoft 365 tenant, users and groups, MFA and Conditional Access, Intune device management, PowerShell automation for joiners and leavers, and tickets and runbooks for everything that goes wrong.

Setup: MacBook + Docker Desktop.

## Documentation

| Section | What's in it |
| --- | --- |
| [docs/phases](docs/phases/01-tenant.md) | One note per phase: objective, what was done, evidence, limits |
| [docs/decisions](docs/decisions/README.md) | Why things were built the way they were, numbered in order |
| [docs/incidents](docs/incidents/00-setup.md) | Incident reports: what broke, root cause, resolution, lessons learned |
| [docs/worklog](docs/worklog/setup-00.md) | Session-by-session log of what was done and learned |
| [evidence](evidence/00-setup/00.md) | Step-by-step write-ups with screenshots, one folder per phase |

Each numbered file links to the one before it, so the trail reads in order from `00`.

## Phases

| Phase | Status | Note | Evidence | Decisions |
| --- | --- | --- | --- | --- |
| Setup | Done | [worklog](docs/worklog/setup-00.md) | [00-setup](evidence/00-setup/00.md) | [00.md](docs/decisions/00.md), [02-setup.md](docs/decisions/02-setup.md) |
| 1: Tenant | Written up | [01-tenant.md](docs/phases/01-tenant.md) | [01-tenant](evidence/01-tenant/00-Secure-first-admin.md) | [03-tenant.md](docs/decisions/03-tenant.md) |
| 2: Groups | Written up | [02-groups.md](docs/phases/02-groups.md) | [02-groups](evidence/02-groups/00-dg-sales-rule.md) | [04-groups.md](docs/decisions/04-groups.md) |
| 3: Scripts | Not started | | | |
| 4: Conditional Access | Not started | | | |
| 5: Intune | Not started | | | |
| 6: Device | Not started | | | |
| 7: Incidents | Not started | | | |

### Setup trail

| Step | Evidence | Decision | Incident |
| --- | --- | --- | --- |
| 00: osTicket and MariaDB | [00.md](evidence/00-setup/00.md) | [00.md](docs/decisions/00.md) | [00-setup.md](docs/incidents/00-setup.md) |
| 01: PowerShell Docker image | [01.md](evidence/00-setup/01.md) | [02-setup.md](docs/decisions/02-setup.md) | [01-setup.md](docs/incidents/01-setup.md) |

## Repository layout

```text
docs/         phases, decisions, incidents, worklog
evidence/     one folder per phase, with step write-ups and images/
scripts/      PowerShell automation (joiners and leavers)
tickets/      ticket records
Dockerfile    PowerShell + Microsoft Graph image (arm64)
```

`evidence-raw/` and `logs/` are local only and gitignored.
