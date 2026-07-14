# Changelog

All notable changes to the Testsigma BDR Kit. Format follows [Keep a Changelog](https://keepachangelog.com/).

## [Unreleased]

### Added
- Automated **PII / leak scan** — `scripts/pii-scan.sh` + `.ps1`, run in CI on every push and pull request via `.github/workflows/pii-scan.yml`. Fails the build on a committed live-data file, a personal email, a phone number, a 24-hex Apollo/record ID, a real `linkedin.com/in/<slug>`, or a regression to a generic template placeholder.
- **Post-onboarding validator** — `scripts/validate-setup.sh` + `.ps1`. Confirms `config.json` exists and is gitignored, every `{{PLACEHOLDER}}` is filled, the sender address ends in `@testsigma.ai`, and the sent list + target-account list are in place.
- **Contribution flow** — `CONTRIBUTING.md`, a PR template with a "no PII" checkbox, and a kit-improvement issue template.
- `.gitattributes` pinning `*.sh` and workflow YAML to LF so the scripts run on Windows checkouts.
- README quality-and-safety section + a CI status badge.

## [1.0.0] - 2026-07-13

### Changed
- Tailored the kit from a generic any-company skeleton into the **Testsigma BDR team kit**: product story, Atto terms, the three proof stories (Hansard / Medibuddy / CRED), the Manager-level-and-above persona lock, verticals, reference customers, the `.ai` sender rule, the full APPROVE-SEND → dedup → MASTER-log process spine, batch-intake routing, the LinkedIn CR/InMail research gate, and the house writing voice — all baked in.
- Slimmed onboarding to per-rep identity + tools only; the shared playbook is no longer re-asked.
- Filled the standard team tool stack (Salesforce / Apollo / LinkedIn Sales Navigator / Google Calendar).

### Security
- PII firewall: live data files gitignored, only `*.example.*` headers ship, and a pre-push + CI leak scan guards the public repo.
