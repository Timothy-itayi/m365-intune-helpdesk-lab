# Worklog: Setup

Each entry has: time spent, what I did, what happened (including errors), what I learned, and what I'd change next time. Newest phase last.

## 2026-09-29 - Setup 00: osTicket and MariaDB

Links: [evidence](../../evidence/00-setup/00.md) | [decision](../decisions/00.md) | [incident](../incidents/00-setup.md)

- Time spent: Not recorded. The incident write-up was committed at 9:27 PM.
- What I did:
  - Added an osTicket lab to the existing Operations Lab project for IT support practice.
  - Ran osTicket and MariaDB as separate services with Docker Compose.
  - Used persistent volumes for the database and attachments.
- What happened (including errors):
  - osTicket could not connect to MariaDB during install. The MariaDB log showed `Access denied for user 'osticket'@'172.18.0.3' (using password: YES)`.
  - Networking was fine, so it was an authentication problem.
  - The existing MariaDB volume held credentials from the first deployment, and MariaDB does not update them when `OST_DB_PASSWORD` changes.
  - The root password had been random (`MARIADB_RANDOM_ROOT_PASSWORD`) and I had not kept it, so I could not log in to reset the `osticket` user.
  - Fixed it by removing and recreating the MariaDB volume. The data was disposable lab data.
- What I learned:
  - An `Access denied` message means the app reached the database and authentication failed.
  - Environment variables do not overwrite credentials already stored in an existing database volume.
  - Check the container logs before assuming a network problem.
- What I'd change next time:
  - Record the MariaDB root password, or set one explicitly, instead of using a random one.
  - Keep the root password separate from the application user's password.
  - Confirm the data really is disposable before deleting a volume.

## 2026-09-29 - Setup 01: PowerShell Docker image

Links: [evidence](../../evidence/00-setup/01.md) | [decision](../decisions/02-setup.md) | [incident](../incidents/01-setup.md)

- Time spent: About 30 minutes, from the first failed build (around 9:40 PM) to the commit at 10:09 PM. This covers the build, the fix and the verification runs, not the write-ups.
- What I did:
  - Wrote a `Dockerfile` for a PowerShell environment with five Microsoft Graph modules installed (`Authentication`, `Users`, `Users.Actions`, `Groups`, `Identity.DirectoryManagement`).
  - Built and tested it on an Apple Silicon Mac with Docker Desktop.
- What happened (including errors):
  - The first build used `powershell:latest` with `--platform=linux/amd64` and failed at the `Install-Module` step with exit code 133 and `BasicBlock requested for unrecognized address`.
  - `powershell:latest` has no `linux/arm64` image, so the amd64 image was running under emulation and the .NET runtime crashed.
  - Switching to `lts-azurelinux-3.0-arm64` fixed the crash. The build finished in 1m 01s with no cached steps.
  - Verification inside the container showed PowerShell 7.4.7, all five Graph modules at 2.40.0, and both `OSArchitecture` and `ProcessArchitecture` reporting `Arm64`.
  - `docker image inspect` and the build dashboard still report `linux/amd64`, which is why Docker prints a platform warning on every run. I have not fixed this yet.
- What I learned:
  - Do not assume `latest` is multi-arch. Check the manifest.
  - `--platform=linux/amd64` on Apple Silicon means emulation, and .NET can crash under it.
  - Crashes in a translator source file (`BuilderBase.h`) point at the emulation layer, not the script.
  - `ProcessArchitecture` shows whether a process is really native, which the image label does not.
  - Zsh expands `$PSVersionTable` unless the PowerShell script is single-quoted.
- What I'd change next time:
  - Pass `--platform` explicitly and run `docker image inspect` after every build.
  - Pin a version tag, not `latest`.
  - Rebuild with `--no-cache --platform=linux/arm64` and confirm the label reads `linux/arm64`. Then mark the decision Accepted.
  - Use a build argument for the base tag if the image ever needs to build on x86.

## 2026-09-30 - Phase 4: MFA and Conditional Access (in progress)

Links: [evidence](../../evidence/04-conditional-access/00-security-defaults-off.md) | [decision](../decisions/06-conditional-access.md) | [phase](../phases/04-conditional-access.md)

- Time spent: Not recorded. The policies were created between 11:26 and 11:31, and the last screenshots were saved at 11:54.
- What I did:
  - Disabled security defaults, replacing them with Conditional Access.
  - Created CA01 (require MFA), CA02 (block legacy authentication) and CA03 (require compliant device, Office 365), all in Report-only.
  - Excluded the break-glass account from CA01.
  - Signed in as Ava Nguyen in a private window, registered Microsoft Authenticator, and looked up her sign-in in the Entra sign-in logs.
- What happened (including errors):
  - No errors. The policy list showed four Microsoft-managed policies already On, including MFA for all users and MFA for admins. I did not create them and have not opened them.
  - The security defaults screenshot was taken before pressing Save, so the saved state is inferred.
  - CA01's exclusion list holds only the break-glass account. The admin is not excluded.
  - Ava was asked for MFA with a number-matching prompt. Her sign-in log shows an Enabled MFA policy named "Require multifactor authentication for all users", which is not CA01's name, so I can't say CA01 caused the prompt.
  - The What If test and the enforce step (4.4) have no evidence yet. The Ava sign-in screenshot shows her IP address and suburb.
- What I learned:
  - Report-only policies enforce nothing. What is enforced now comes from the Microsoft-managed policies.
  - The portal now labels "All cloud apps" as "All resources".
- What I'd change next time:
  - Screenshot after saving, and open the Grant panel so the control is visible.
  - Open the Microsoft-managed policies and check their exclusions before relying on the break-glass account.
  - Open the full Conditional Access tab for the sign-in so every evaluated policy is visible.
  - Blur the IP address before screenshotting sign-in logs.
  - Record the start time.

## 2026-09-30 - Phase 5: Intune policies

Links: [evidence](../../evidence/05-intune/00-mdm-user-scope.md) | [decision](../decisions/07-intune.md) | [phase](../phases/05-intune.md)

- Time spent: Not recorded. The screenshots were saved at 12:17.
- What I did:
  - Set the MDM user scope to All.
  - Created a compliance policy (`Win-Compliance-Baseline`), a Settings catalog profile (`Win-Config-Baseline`), an update ring (`Win-Updates-Standard`) and a Windows Terminal app assignment, all for `SG-All-Staff`.
- What happened (including errors):
  - Every screenshot shows the break-glass account signed in. It is the account used to read the Entra sign-in logs, and these pages were captured in the same session.
  - The update ring and app screenshots are the Review + create page, taken just before Create. The config profile was later shown as a saved object, with a 900-second inactivity limit and Allow Windows Consumer Features = Allow. Its assignment list was empty on the review page.
  - The update ring shows a 5-day feature update deferral and no deadline, where the plan said a 5-day deadline.
  - The compliance policy screenshot doesn't show BitLocker, Secure Boot or Firewall.
- What I learned:
  - A wizard's Review + create page proves intent, not that the object exists.
  - The tutorial's "deadline" and the update ring's "feature update deferral" are different settings.
- What I'd change next time:
  - Screenshot each object after saving, from its Properties and Assignments pages.
  - Expand collapsed sections before capturing.
  - Record the start time.

## 2026-09-30 - Phase 6: Enrol a Windows device (skipped)

Links: [phase](../phases/06-device.md) | [decision](../decisions/08-device-enrolment-skipped.md)

- Time spent: None. The phase was not attempted.
- What I did:
  - Decided to skip Phase 6 because there is no Windows machine to use.
  - Updated the README, the phase notes and the decision logs to say device enrolment was not tested and why.
- What happened (including errors): Nothing was run, so nothing failed.
- What I learned:
  - Docker on macOS can't stand in for a Windows desktop, so a Mac-only lab can't cover Intune enrolment.
  - Skipping leaves the Phase 5 policies as configuration only, and CA03 stuck in Report-only.
- What I'd change next time: Check for a usable Windows device before starting the Intune phases, or plan a Windows VM route.

## 2026-09-30 - Scope and teardown

Links: [decision](../decisions/09-scope.md) | [README](../../README.md)

- Time spent: Not recorded.
- What I did:
  - Reframed the README around the Microsoft 365 work in Phases 1 to 5.
  - Marked tickets, incident write-ups and runbooks as out of scope, since ticketing was done in a prior project.
  - Noted that the tenant is temporary and will be torn down.
- What happened (including errors): Nothing failed. This was a documentation change.
- What I learned: Once the tenant is torn down, missing screenshots can't be retaken.
- What I'd change next time: Capture every screenshot from the saved object before starting teardown.

## 2026-09-30 - Runbooks from the lab steps

Links: [runbooks](../runbooks/README.md) | [decision](../decisions/09-scope.md)

- Time spent: Not recorded.
- What I did: Wrote six runbooks (MFA re-registration, new starter, leaver, password reset, licence assignment failure, missing dynamic group member) in one layout, using the lab's own steps and screenshots.
- What happened (including errors): Nothing was run. The new starter, leaver and password reset runbooks follow steps that were run. The MFA, licence and dynamic group runbooks describe faults that were not reproduced, and say so.
- What I learned: A runbook written before an incident is a draft until someone follows it.
- What I'd change next time: Run each fault once and capture the fix screenshots.
