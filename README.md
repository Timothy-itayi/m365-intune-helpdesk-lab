# m365-intune-helpdesk-lab

A small-business IT environment run the way a service desk or MSP runs one: a Microsoft 365 tenant, users and groups, MFA and Conditional Access, Intune device management, PowerShell automation for joiners and leavers, and tickets and runbooks for everything that goes wrong.

Setup: MacBook + Docker Desktop.

## Documentation

| Section | What's in it |
| --- | --- |
| [docs/decisions](docs/decisions/README.md) | Why things were built the way they were, numbered in order |
| [docs/incidents](docs/incidents/00-setup.md) | Incident reports: what broke, root cause, resolution, lessons learned |
| [docs/worklog](docs/worklog/setup-00.md) | Session-by-session log of what was done and learned |
| [evidence/00-setup](evidence/00-setup/00.md) | Setup write-ups with screenshots, numbered in order |

Each numbered file links to the one before it, so the trail reads in order from `00`.

## Setup trail

| Step | Evidence | Decision | Incident |
| --- | --- | --- | --- |
| 00: osTicket and MariaDB | [00.md](evidence/00-setup/00.md) | [00.md](docs/decisions/00.md) | [00-setup.md](docs/incidents/00-setup.md) |
| 01: PowerShell Docker image | [01.md](evidence/00-setup/01.md) | [02-setup.md](docs/decisions/02-setup.md) | [01-setup.md](docs/incidents/01-setup.md) |

## Repository layout

```text
docs/         decisions, incidents, worklog
evidence/     numbered evidence folders and screenshots
scripts/      PowerShell automation (joiners and leavers)
tickets/      ticket records
Dockerfile    PowerShell + Microsoft Graph image (arm64)
```

`evidence-raw/` and `logs/` are local only and gitignored.

## Roadmap

Evidence folders are reserved for the remaining phases and are empty so far:

1. `01-tenant`
2. `02-groups`
3. `03-scripts`
4. `04-conditional-access`
5. `05-intune`
6. `06-device`
7. `07-incidents`
