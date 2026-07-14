# Testsigma BDR Team Kit

[![PII / leak scan](https://github.com/robertgorham-BDR/Auto-Outreach-Skills-/actions/workflows/pii-scan.yml/badge.svg)](https://github.com/robertgorham-BDR/Auto-Outreach-Skills-/actions)

The AI-assisted BDR operating system the Testsigma sales-development team runs on — email + LinkedIn + calls, end to end, at a 9/10 quality bar. **The Testsigma playbook is already built in:** the product story, the ICP and personas, the proof points, the house voice, and the full send-safety pipeline all ship configured. When you join, you configure **only your own identity and tools** (your name, your `.ai` sender, your timezone, your Apollo login, your assigned accounts, your quota) and start running batches.

> **What this is NOT:** a blank any-company skeleton, and not a fire-and-forget bot. The methodology is Testsigma's and it is opinionated. Your agent does the research, drafting, and QA autonomously; **you** approve every send. You personalize the identity, not the strategy.

---

## Who this is for

New (and existing) **Testsigma BDRs / SDRs**. If you were just handed a territory and told to start booking meetings for our agentic AI test-automation platform, this is your starting point. Clone it, run the onboarding skill so the agent knows who you are and what you have access to, and you have the same battle-tested motion the rest of the team uses.

---

## What Testsigma is (already baked into the kit)

Testsigma is an **agentic AI-powered, unified test automation platform**. You write tests in plain English; AI creates, runs, and heals them — across web, mobile, API, desktop, Salesforce, and SAP. Founded 2019, HQ San Francisco.

The kit ships with all of this pre-loaded so your drafts are on-message from day one:

- **Product knowledge** — Atto (the AI-coworker suite: Generator, Sprint Planner, Runner, Analyzer, Healer, Optimizer), Atto 2.0 (intent-based self-healing, coverage discovery, risk analysis), NLP (plain-English tests), Copilot (generate tests from prompts, Figma, Jira, screenshots), self-healing (auto-fix broken locators when the UI changes, up to ~90% maintenance reduction).
- **The three core value props + proof stories** — flaky/brittle tests → self-healing (Hansard cut regression from 8 weeks to 5); too much time creating/running tests → plain English + parallel execution (Medibuddy, 2,500 tests, ~50% maintenance cut); can't scale coverage → NLP + AI agent + cross-browser (CRED, 90% regression coverage, 5x faster).
- **Personas** — Manager-level and above only (QA Manager; Director/VP of QA; Software Engineering Manager; Director/VP Engineering; VP Eng / CTO only with buyer intent). Lead/Senior/Principal/Staff/SDET/IC titles are excluded.
- **Top verticals** — SaaS/Tech, FinTech, Retail/E-Commerce, Healthcare/Digital Health, Telecom, Pharma.
- **House voice** — consultative and peer-to-peer, plain language, no em dashes, one CTA, ask-don't-assert, 75-99 word first touch.

You don't rewrite any of that. You point it at your accounts and send from your name.

---

## What you configure (per rep, via onboarding)

Only what is individual to you — every one of these is a `{{PLACEHOLDER}}` the onboarding skill fills:

| You provide | Token |
|---|---|
| Your full name / first name | `{{FULL_NAME}}` / `{{FIRST_NAME}}` |
| Your work email + your `.ai` sender | `{{WORK_EMAIL}}` / `{{SENDER_EMAIL}}` |
| Your timezone | `{{TIMEZONE}}` |
| Your Apollo login + email-account IDs | `{{APOLLO_ACCOUNT_EMAIL}}` / `{{APOLLO_AI_EMAIL_ACCOUNT_ID}}` / `{{APOLLO_COM_EMAIL_ACCOUNT_ID}}` |
| Your assigned accounts / TAM slice | `{{ASSIGNED_ACCOUNTS_OR_TAM_SLICE}}` |
| Your Apollo sequence IDs | `{{SEQUENCE_IDS}}` |
| Your quota + daily activity targets | `{{MONTHLY_SAL_TARGET}}` / `{{DAILY_EMAILS}}` / `{{DAILY_LINKEDIN}}` / `{{DAILY_CALLS}}` |
| Your LinkedIn profile | `{{LINKEDIN_PROFILE_URL}}` |

---

## Quick start

1. On GitHub, click **Use this template → Create a new repository** (into your **work** GitHub account, never a personal one).
2. **Clone** your new repo into a folder on your work desktop.
3. **Open your agent** (Claude Code / Cowork) in that folder.
4. **Run the onboarding skill** — say *"run the onboarding skill."* It interviews you, fills every `{{PLACEHOLDER}}` with your identity and tools, and helps you connect Apollo / email / LinkedIn. See `SETUP.md` for the by-hand version.
5. Add your accounts to `data/target-accounts.csv`, then start a session and ask for one small batch. The safety gates (dedup, persona, scope, QA, per-send verification, MASTER logging) are already wired — they just read *your* config.

---

## Why the repo ships empty of people-data (the PII firewall)

**This repository is public.** The Testsigma *playbook* is public/marketing-safe, so it ships in the clear. Everything that is operator-specific or a real person's data does **not**:

- No contacts, no sent history, no warm leads, no call logs, no do-not-contact names, no target-account lists.
- No Apollo/CRM logins, sequence/campaign IDs, webhooks, or API keys.
- Your filled-in `config.json`, your live CSVs, and your working memory are **gitignored** — the templates ship as `*.example.*` headers only, and you fill the live files through real work.
- Before any push, a PII scan greps the tree for names, emails, phone numbers, and tool-ID patterns; a real person's data that isn't a `{{PLACEHOLDER}}` blocks the commit.

So: the *strategy* is shared, your *data* never is.

---

## Quality and safety (automated)

Three checks keep the repo clean and your setup correct:

- **`scripts/pii-scan.sh`** — run before every push. It also runs in CI on every push and pull request via `.github/workflows/pii-scan.yml` (the badge at the top shows its status). It blocks anything that would leak a real person's data or check in operator-specific state: personal emails (`@gmail.com`, `@yahoo.com`, a specific real address), phone numbers, Apollo/record IDs (24-hex-char), real `linkedin.com/in/<slug>` URLs, and any live-data file that should be gitignored. Template tokens like `{{FIRST_NAME}}`, the `firstname.lastname@testsigma.ai` sender pattern, and labelled example names pass clean.
- **`scripts/validate-setup.sh`** — run right after onboarding to confirm every `{{PLACEHOLDER}}` was filled and your config is complete before you send anything.
- **`CONTRIBUTING.md`** — the fork → PR flow for improving the shared kit, kept separate from your gitignored per-rep data.

---

## Core principles baked in (keep these)

- **Every message runs the full gate, every time** (scope → dedup → persona → research → anchor → load-canon → draft → QC → send → log). See `skills/_shared/outreach-gauntlet.md`.
- **Nothing sends without your explicit APPROVE SEND.**
- **TAM-only prospecting** — only accounts on your approved target list.
- **Send from your `.ai` address.** The `.com` address is only for rare, fully-customized replies to a warm/inbound prospect.
- **Your data never leaks** — this kit ships empty of people-data on purpose.

---

*The Testsigma BDR motion, packaged so a new teammate can be running it the same day. Configure your identity, point it at your accounts, and good hunting.*
