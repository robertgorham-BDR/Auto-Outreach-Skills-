# Setup — go from clone to running (per rep)

The Testsigma playbook is already in this kit — the product story, ICP/personas, proof points, house voice, and send-safety pipeline are configured. Setup is just teaching the agent **who you are and what you have access to**, then connecting your tools.

**First run = discovery before execution.** Before any outreach, the agent configures to YOUR machine and work accounts: it auto-detects what it can (work folder, connected tools, whether a git remote is set), then asks you in ONE consolidated pass for the rest and gets your approval before creating or changing anything. It establishes:
- **Work folder** on your Desktop (where this system lives + your live files) — created only with your OK.
- **Your assigned WORK GitHub repo** — under your *work* GitHub account, created from this template by Testsigma, **never a personal repo**, and never pushed to personal. If none is assigned yet, the agent flags it.
- **Tool/connection inventory** — work Chrome profile, Apollo (web + API), work email for reply capture, LinkedIn Sales Navigator, and Salesforce/G2 via your WORK claude.ai "Work" browser tab group.

Then it does the interview below. Full protocol: `skills/onboarding/SKILL.md` Step 0.

Two ways to do this: let your agent run it (fast), or do it by hand.

## Option A — Agent-driven (recommended)
1. Open your AI agent (Claude Code / Cowork) in this folder.
2. Say: **"Run the onboarding skill."**
3. It will interview you for your identity + tools, fill `config.json`, replace every placeholder, and help connect Apollo / email / LinkedIn. Answer accurately — your sender address, Apollo IDs, and assigned accounts have to be exactly right or your first batch mis-sends.

## Option B — By hand
Work through these in order. The onboarding skill (`skills/onboarding/SKILL.md`) is the same checklist if you want detail. You are filling identity + tools only — you are **not** rewriting the Testsigma product story, personas, proof points, or voice; those are already correct.

1. **Config:** `cp config.example.json config.json`, then fill in every `{{PLACEHOLDER}}` — your name, `{{WORK_EMAIL}}`, `{{SENDER_EMAIL}}` (= `firstname.lastname@testsigma.ai`), `{{TIMEZONE}}`, `{{APOLLO_ACCOUNT_EMAIL}}`, `{{APOLLO_AI_EMAIL_ACCOUNT_ID}}`, `{{APOLLO_COM_EMAIL_ACCOUNT_ID}}`, `{{ASSIGNED_ACCOUNTS_OR_TAM_SLICE}}`, `{{SEQUENCE_IDS}}`, quota targets, `{{LINKEDIN_PROFILE_URL}}`. This one file drives the whole kit.
2. **Sender check:** confirm `{{SENDER_EMAIL}}` is your **`.ai`** address. All outreach sends from `.ai`. The `.com` address (`{{APOLLO_COM_EMAIL_ACCOUNT_ID}}`) is only for rare, fully-customized replies to a warm/inbound prospect (e.g. someone who asked for a demo).
3. **Placeholders:** replace `{{...}}` tokens in `CLAUDE.template.md` → save as `CLAUDE.md`; `AGENTS.template.md` → `AGENTS.md`; and anywhere else a per-rep token appears in `memory/` + `skills/`. Grep for `{{` when done — zero hits = configured.
4. **Tools:** connect Apollo (enrichment + sending), your work email (reply capture), and LinkedIn Sales Navigator. The skills call these by the account/IDs in `config.json`.
5. **Empties:** copy each `*.example.*` file to its live name (`cp MASTER_SENT_LIST.example.csv MASTER_SENT_LIST.csv`, same for `data/*.example.csv` and `memory/*.example.md`). The live names are gitignored, so you fill them through real work and `.gitignore` keeps them from ever being pushed.
6. **First run:** start a session, ask for one small prospect batch from your assigned accounts, and confirm the gates use *your* sender, *your* Apollo account, and the Testsigma persona filter.

## Operating rules baked in from live runs (your agent honors these out of the box)
- **Quota semantics:** "send N emails / M LinkedIn" always means **N net-new first-touch emails and M new connection requests** — due follow-up tasks are pulled first and done IN ADDITION, never counted toward N/M.
- **Batch-intake routing:** on any "send N / M" request the agent surveys your existing sequences FIRST, then routes each contact preferring a sequence with a manual email step > a sequence with an automated-template step > a LinkedIn step > a one-off manual email. If routing is unclear it asks ONE upfront multiple-choice question, then runs.
- **Formulas are editable, on request.** Say "use this formula instead" / "write them more like X" and the agent captures your version verbatim, writes it into the writing canon as a dated override (old formula archived), confirms with one sample, and uses yours from then on. Style is swappable; safety gates (verified-email only, dedup/DNC, no fabrication, one batch approval, MASTER logging, sender rules) are not.
- **Performance analysis on request:** "analyze my outreach performance" runs a read-only statistical review (rates with confidence intervals by formula/persona/anchor/subject; no recommendations from tiny samples) and proposes KEEP/CHANGE/TEST — changes only apply through the formula-override flow with your approval.
- **Security at transfer:** everything operator-specific lives in gitignored files (`config.json`, live CSVs/memory). Before any push, the agent greps for names/emails/IDs that aren't yours and blocks the commit if it finds someone else's.

## The one rule that matters most
**This repository is public.** Never paste another rep's contacts, sent list, DNC names, account list, or Apollo/tool IDs into a tracked file — and never paste your own live data into a file that isn't gitignored. Bring your own data through the live (gitignored) files only.

## What "good" looks like after setup
- `grep -r "{{" .` returns nothing.
- The only person's name/email in the repo is yours.
- `{{SENDER_EMAIL}}` in `config.json` is your `.ai` address.
- `config.json` is gitignored and not staged.
- A dry-run batch reads your config end to end and applies the Testsigma persona filter + house voice automatically.
