# 3.7 Actions Log

Previous: [04-verify-portals.md](04-verify-portals.md)

Decision: [05-scripts.md](../../docs/decisions/05-scripts.md)

## Steps

```powershell
Import-Csv ./logs/actions.csv | Format-Table
```

Expected: six rows, one per starter. The log file is written by the scripts and is gitignored, so it only exists locally.

## Evidence

![Actions log](images/actions-log.png)

| Timestamp | Action | UPN | Department | Ticket |
| --- | --- | --- | --- | --- |
| 2026-09-29T14:26:45 | Starter | `ava.nguyen@helpdeskco123.onmicrosoft.com` | Sales | INC-0001 |
| 2026-09-29T14:26:54 | Starter | `ben.carter@helpdeskco123.onmicrosoft.com` | Sales | INC-0001 |
| 2026-09-29T14:27:01 | Starter | `chloe.martin@helpdeskco123.onmicrosoft.com` | Operations | INC-0001 |
| 2026-09-29T14:27:08 | Starter | `dan.okafor@helpdeskco123.onmicrosoft.com` | Operations | INC-0001 |
| 2026-09-29T14:27:15 | Starter | `emma.rossi@helpdeskco123.onmicrosoft.com` | Finance | INC-0001 |
| 2026-09-29T14:29:40 | Starter | `farid.haddad@helpdeskco123.onmicrosoft.com` | Finance | INC-000 (cut off by the terminal edge) |

Every row was written by the admin account. The last ticket value is cut off at the right edge of the terminal in the screenshot. It should be `INC-0001`, but the screenshot does not show the full value.

The timestamps look like UTC, which is the container default. They read about ten hours behind local time (UTC+10), and this was run around midnight local.

Farid's entry is 2 minutes 25 seconds after Emma's, while the others are 7 to 9 seconds apart. Nothing in the evidence explains the gap.
