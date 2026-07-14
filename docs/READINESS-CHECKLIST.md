# Readiness Checklist — before this kit goes to the team

Run top to bottom. The kit is ready to share with new Testsigma reps when every box is checkable. The Testsigma playbook (product, personas, proof points, voice) is baked in and marketing-safe; the checks below confirm the playbook is complete and that **no rep-specific or real-person data** ships with it.

## Safety (do these before any push — the repo is public)
- [ ] PII scan clean: grep the whole tree for any real name, email, phone, LinkedIn slug, or tool ID. Zero hits outside `*.example.*` menu options and the public Testsigma reference-customer list.
- [ ] `config.json`, `.env`, and all live data files are gitignored and unstaged.
- [ ] Only `*.example.*` blank templates ship; no live `MASTER_SENT_LIST.csv` / `target-accounts.csv` / `do-not-contact.md` / warm-leads / call-log / pipeline.
- [ ] No Apollo/sequence/campaign IDs, webhooks, or API keys anywhere in tracked files.
- [ ] No customer/account names beyond the public Testsigma reference list; no competitor names or positioning (point reps to their team's enablement docs instead).
- [ ] Every rep-specific field is a `{{PLACEHOLDER}}` (name, `.ai` sender, Apollo IDs, assigned accounts, sequence IDs, quota, LinkedIn URL) — never a real value.

## Completeness — the Testsigma playbook is present and correct
- [ ] Front door: `README.md`, `SETUP.md`, `ARCHITECTURE.md` present and accurate.
- [ ] Brain: `CLAUDE.template.md` (product story, Atto/Copilot/self-healing terms, three value props + proof stories, persona filter, verticals), `AGENTS.template.md`.
- [ ] Config: `config.example.json` (every per-rep field placeholdered) + `voice-profile.md` (the Testsigma house voice, filled).
- [ ] Engine: `skills/_shared/` (gauntlet + QC rubric + learning-loop).
- [ ] Channels: `skills/email/`, `skills/linkedin/`, `skills/calls/`, `skills/ops/` — each end-to-end.
- [ ] Onboarding: `skills/onboarding/SKILL.md` (identity + tools interview).
- [ ] Prompts: `onboarding-prompt`, `build-batch-prompt`, `run-my-day-prompt`.
- [ ] Canon: `memory/context/` (voice-profile, qa-rules, gold-standards, writing-canon-index) reflects the house voice — no em dashes, one CTA, ask-don't-assert, 75-99 word first touch, `Best,` / newline / first name sign-off.
- [ ] Data/schema: `data/*.example.csv`, `analytics/db_init.sql`, `sequences/_TEMPLATE-sequence/`.

## Correctness (dogfood it)
- [ ] A test rep uses the GitHub template, clones into a desktop folder, pastes `onboarding-prompt.md`, and the agent runs the identity + tools interview (name, `.ai` sender, Apollo IDs, assigned accounts, quota).
- [ ] After onboarding: grep `{{` returns nothing; the only name/email in the repo is the test rep's; `{{SENDER_EMAIL}}` is their `.ai` address.
- [ ] Dry run: the agent builds one small batch and the gauntlet visibly runs every gate (scope → dedup → live research → anchor → draft → QC table) and STOPS for APPROVE SEND.
- [ ] The batch reflects the baked-in playbook without prompting: Manager-level+ persona filter applied, house voice, one named proof story, sends staged from the `.ai` sender.
- [ ] The QC table appears automatically, unprompted, with the batch.

## The distribution message (what the new rep receives)
> On GitHub, click **Use this template** to create your own repo (in your **work** account). Clone it into a folder on your work desktop, open your AI agent (Claude Code / Cowork) in that folder, and paste `prompts/onboarding-prompt.md`. Answer its interview accurately — it's calibrating the system to *you* (your name, your `.ai` sender, your Apollo login, your assigned accounts, your quota); the Testsigma playbook is already built in. Then add your accounts to `data/target-accounts.csv` and paste `prompts/build-batch-prompt.md` to run your first batch. Nothing ever sends without your APPROVE SEND.

## Live-run lessons already baked in
- [x] Source-width rule (expect 50-70% dedup overlap on worked accounts).
- [x] Sales-Nav depth fallback when a public profile is activity-thin.
- [x] Live-title vs enrichment-title reconciliation as a hard gate (judge persona on the live headline).
- [x] Manager-level-and-above persona filter (drop Lead/Senior/Principal/Staff/SDET/IC titles).
- [x] Thought-leadership-opener as a per-rep config toggle (canon judgment call).
