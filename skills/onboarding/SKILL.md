---
name: onboarding
description: "Configure this Testsigma BDR Starter Kit for a new rep. Run once, right after cloning. Testsigma's company, product, ICP, proof points, house voice, and outreach process are already baked into the kit — onboarding does NOT re-ask about them. It only collects what is unique to THIS rep (name, work + sender email, timezone, Apollo login + email-account IDs, LinkedIn, assigned accounts, quota + daily targets), sets up the machine/repo/tools, optionally does a light personal-voice calibration on top of the house voice, fills every {{PLACEHOLDER}}, and verifies the only identity left in the repo is the rep's own."
---

# Onboarding — set this kit up for THIS rep

Everything about *Testsigma* is already in this kit: the company/product facts, the persona lock, the proof points, the house voice, and the full outreach gauntlet. Your job is NOT to re-teach the agent about Testsigma. Your job is to bind the kit to **one rep** — their identity, their Apollo login, their assigned accounts, their quota — so the same house system runs as *theirs*.

## Golden rules
- **Do not re-ask what is already baked in.** Company, product, ICP, personas, proof points, verticals, house voice, sender rules, and the pipeline are constants for every Testsigma BDR. Read them; never interview the rep about them.
- **Interview only for what is rep-specific.** The list below is short on purpose.
- **One config, many files.** Fill `config.json` first, then propagate its values into the `{{PLACEHOLDERS}}`.
- **Never paste in another rep's data.** Any real name / email / account / Apollo ID that isn't THIS rep's is a leak — flag and remove.
- **The house voice is the floor; the rep's personality is an optional layer on top.** You never rewrite the structural rules; you may lightly calibrate tone if the rep wants.

---

## Step 0 — Discovery & machine setup (auto-detect FIRST, then one consolidated ask)
"Know before you go." Before interviewing, **auto-detect everything detectable**, then fold the gaps into a single ask so the rep answers once. Establish:

- **Work folder on the machine.** Where does this system live / run? (A working directory on the rep's Desktop, e.g. `Desktop\Work`, holding `MASTER_SENT_LIST`, `memory/`, `skills/`, `batches/`.) Confirm this repo folder IS that work folder. If none exists, propose creating it — **ask before creating** (persistent change). Record the confirmed path.
- **Assigned WORK GitHub repo (Testsigma work account — NOT personal).** A Testsigma BDR's repo is under their **work** GitHub account and assigned by the company; they will NOT have a personal repo. Confirm: (1) the rep's work GitHub account, (2) that **this folder is that assigned Testsigma work repo** (check `git remote -v` points at the assigned repo, not a personal one), (3) the tracked branch. **Never push to a personal repo — only the assigned work repo.** If no repo is assigned yet, flag it: the rep or their manager must assign one before git-backed work.
- **Tool / connection inventory.** Detect what's connected vs missing: the rep's work Chrome profile (via the browser extension), **Apollo** (web login + MCP — the sending + enrichment tool), work Gmail (reply monitoring), Calendar / Drive, and **Salesforce / G2 via the rep's WORK claude.ai "Work" browser tab group** (the only sanctioned path to SF/G2 — never sign in from a personal browser). List present-vs-absent MCP tools and tell the rep exactly what to connect.
- **Survey the rep's existing Apollo sequences (do this, don't skip it).** In Apollo's web UI, list the sequences the rep owns and read each one's **step structure** — which email steps are a **manual task** (creates a task; safe to enroll; we send tailored content) vs an **automated / scheduled template** (auto-fires on enroll — you must know its exact template body first, or you double-send). This defines the routing menu the daily batch uses. Note any LinkedIn steps. Record the sequence IDs into `config.json` (gitignored) — never a shared file.

**The flow:** auto-detect → **one upfront consolidated ask** (multiple-choice / checklist — "here's what I found, here's what I still need, here's what you must do") → get approval for anything persistent → configure → **report done / pending / blocked** → persist the resolved config so later sessions don't re-ask. Then proceed to the short interview.

## Step 1 — Interview the rep (fill `config.json`) — REP FIELDS ONLY
Copy `config.example.json` → `config.json` first. The company / product / ICP / persona / proof-point / house-voice / CTA / research / pipeline sections are **Testsigma house defaults** — populate them directly from the baked-in canon (`CLAUDE.template.md`, `memory/context/`), do **not** interview the rep on them. Then ask the rep only for the fields below. Keep it conversational; batch related questions.

### 1. Rep identity & logistics
- **Full name** → `{{FULL_NAME}}` (and first name → `{{FIRST_NAME}}`).
- **Work email** → `{{WORK_EMAIL}}`.
- **Sender email** → `{{SENDER_EMAIL}}` — the rep's Testsigma `.ai` address, formatted `firstname.lastname@testsigma.ai`. This is the default From on every outbound send. (The `.com` address exists only for a rare, direct, fully-customized reply to a warm / inbound prospect — never the batch default.)
- **Timezone** → `{{TIMEZONE}}` (IANA form, e.g. `America/New_York`).
- **LinkedIn profile URL** → `{{LINKEDIN_PROFILE_URL}}`.

### 2. The rep's Apollo account
- **Apollo login email** → `{{APOLLO_ACCOUNT_EMAIL}}` (the account the agent operates in).
- **Apollo `.ai` email-account ID** → `{{APOLLO_AI_EMAIL_ACCOUNT_ID}}` (the connected mailbox for the `.ai` sender; found in Apollo's email-account settings).
- **Apollo `.com` email-account ID** → `{{APOLLO_COM_EMAIL_ACCOUNT_ID}}` (exception-only sender).
- **The rep's sequence IDs** → `{{SEQUENCE_IDS}}` (from the Step 0 sequence survey).

### 3. Assigned accounts / TAM slice
- **Which accounts is this rep allowed to prospect?** → `{{ASSIGNED_ACCOUNTS_OR_TAM_SLICE}}`. Testsigma prospecting is TAM-only; the rep works an assigned slice of the target list. Get the exact scope (a named account list, a tier, a vertical cut, a region) and drop it into `data/target-accounts.csv`. If accounts are shared across a team, confirm how the agent verifies an account/contact is THIS rep's before touching it (e.g. the CRM Account Owner field) so it never steps on a teammate.

### 4. Quota & daily targets
- **Monthly SAL target** → `{{MONTHLY_SAL_TARGET}}` (BANT-qualified opportunities — the hard expectation).
- **Daily activity targets** → `{{DAILY_EMAILS}}` emails, `{{DAILY_LINKEDIN}}` LinkedIn touches, `{{DAILY_CALLS}}` calls. Derive from funnel math if the rep only has the monthly number.
- Best send window / anything to avoid (e.g. no evening sends).

### 5. Personal-voice calibration (OPTIONAL — a light layer on the house voice)
The house voice is already locked (consultative, peer-to-peer, no em dashes, ask-don't-assert, one CTA, 75–99-word Touch 1, `Best,` + first-name sign-off). You are NOT re-eliciting a voice from scratch. Offer the rep a light calibration on top:
- "Want to tune the tone at all? You can paste one or two lines you'd naturally open a cold intro with, and I'll match the rhythm — or we keep the house default."
- Capture only the **Tone DNA** deltas (a few adjectives, sentence-length feel, a short list of words they'd never use). If the rep declines, keep the house default as-is.
- The structural rules do not move. Personality is the only tunable.

Read the rep-field values in `config.json` back for confirmation before moving on.

## Step 2 — Light-touch voice calibration (`memory/context/voice-profile.md`)
Fill the identity line with the rep's name (`{{FULL_NAME}}`, at Testsigma) and, if they opted into Step 1.5, drop their Tone DNA deltas into the "Tone DNA" section in their words. **Keep every structural hard rule exactly as written** — no em dashes, one CTA, ask-don't-assert, 4-paragraph standard, 75–99-word range, `Best,` + first-name sign-off. If the rep declined calibration, leave the house tone as the default and just set the name.

## Step 3 — Propagate placeholders
Replace every `{{...}}` across the kit from `config.json`:
- Rep tokens: `{{FULL_NAME}}`, `{{FIRST_NAME}}`, `{{WORK_EMAIL}}`, `{{SENDER_EMAIL}}`, `{{TIMEZONE}}`, `{{LINKEDIN_PROFILE_URL}}`, `{{APOLLO_ACCOUNT_EMAIL}}`, `{{APOLLO_AI_EMAIL_ACCOUNT_ID}}`, `{{APOLLO_COM_EMAIL_ACCOUNT_ID}}`, `{{SEQUENCE_IDS}}`, `{{ASSIGNED_ACCOUNTS_OR_TAM_SLICE}}`, `{{MONTHLY_SAL_TARGET}}`, `{{DAILY_EMAILS}}`, `{{DAILY_LINKEDIN}}`, `{{DAILY_CALLS}}`.
- House-voice constants (fill directly, no interview): sign-off line 1 = `Best,` and sign-off line 2 = `{{FIRST_NAME}}`; cold-email word range = 75 to 99; company = Testsigma; any `{{YOUR_NAME}}` / `{{YOUR_FIRST_NAME}}` maps to the rep's name.
- Save the template files under their real names: `CLAUDE.template.md` → `CLAUDE.md`; `AGENTS.template.md` → `AGENTS.md`.
- Grep for `{{` again across the repo — **zero hits = fully configured.**

## Step 4 — Seed the empties
Copy each `*.example.*` to its live (gitignored) name: `MASTER_SENT_LIST`, `data/target-accounts.csv`, `data/suppression-list.csv`, `memory/do-not-contact.md`, `memory/warm-leads.md`, `memory/call-log.md`, `memory/pipeline-state.md`. They stay the rep's own and never get pushed. Load the rep's assigned accounts into `data/target-accounts.csv`.

## Step 5 — Connect tools
Walk the rep through connecting their stack: work Chrome profile, Apollo (web + MCP), work Gmail (reply monitoring), Calendar, and the Work tab group for SF/G2. Mark any missing tool's steps as manual until it's connected.

## Step 6 — Verify
- Grep the repo for `{{` → empty.
- Grep for the new rep's name / email only — **no one else's name, email, or Apollo ID appears anywhere.**
- `config.json` is gitignored and unstaged; the only identity committed anywhere in the repo is the rep's own.
- **Dry run:** have the rep ask for a single small batch and confirm the gauntlet reads the baked-in Testsigma ICP + proof points, uses the rep's `.ai` sender and assigned accounts, writes in the house voice, and stops for approval before any send.

Done: the Testsigma house system is now bound to this rep. Hand off to `AGENTS.md`.
