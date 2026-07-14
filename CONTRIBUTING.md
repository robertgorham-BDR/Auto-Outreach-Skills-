# Contributing to the Testsigma BDR Kit

This repo is the **shared** BDR playbook. Improvements are welcome from anyone on the team — but the golden rule is simple:

> **Only the playbook changes. Never anyone's data.**

Methodology, wording, skills, gates, and docs are fair game. Contacts, sent history, do-not-contact names, account lists, Apollo/CRM IDs, and personal email addresses are **never** committed — they live in each rep's gitignored `config.json` and local files.

---

## How to propose a change

You don't push directly to the shared repo. Use the fork → pull request flow:

1. **Fork** this repo (or, if you cloned via *Use this template*, work in your own copy).
2. Make your change on a branch. Keep anything rep-specific as a `{{PLACEHOLDER}}` token — don't hardcode your name, sender, or IDs into a shared file.
3. **Run the leak scan before you push:**
   ```bash
   bash scripts/pii-scan.sh        # macOS / Linux / Git-Bash
   pwsh scripts/pii-scan.ps1       # Windows PowerShell
   ```
   It must print a PASS line and exit 0. If it flags something, fix it before opening the PR.
4. **Open a pull request** into `main`. Fill in the PR template — including the checkbox confirming the scan passed and that no real data is included.
5. A maintainer reviews and merges. CI runs the same leak scan on every PR, so a leak fails the check automatically.

---

## What belongs here

| ✅ Yes | ❌ No |
|--------|-------|
| Voice, QA rules, gold-standard examples (fictional prospects only) | Real prospect / customer / teammate names |
| Skills, gates, process improvements | Contacts, sent lists, DNC names, account lists |
| Docs, onboarding, wording fixes | Apollo / CRM logins, sequence or campaign IDs, API keys |
| New reference customers **cleared for public/marketing use** | Any email address of a real person |

If you're unsure whether something is safe to commit, it isn't — ask a maintainer first.

---

## Style

- Match the house voice (see `memory/context/`): plain, consultative, no em dashes, one CTA, ask-don't-assert.
- Keep examples fictional and clearly labelled (e.g. *Jordan Lee at Acme Pay*).
- Small, focused PRs review faster than sweeping ones.
