# Session Startup Protocol (agent reads this at the start of every session)

> Save as `AGENTS.md` after onboarding fills the per-rep placeholders. This tells the agent what to load and in what order before doing any work. The Testsigma playbook is already in these files — you are loading it, plus this rep's identity + tools from `config.json`.

## Read, in order
1. `CLAUDE.md` — the operating brain: the Testsigma playbook (product, personas, proof points, voice), the hard rules, and the send pipeline.
2. `skills/_shared/outreach-gauntlet.md` — the mandatory end-to-end process for any message.
3. `memory/context/writing-canon-index.md` — the writing-canon entry point (house voice, QA rules, gold standards).
4. `config.json` — this rep's identity, `.ai` sender, timezone, Apollo account + email-account IDs, assigned accounts/TAM slice, sequence IDs, quota.
5. State files (once built through real work): `memory/warm-leads.md`, `memory/pipeline-state.md`, latest `MASTER_SENT_LIST.csv` tail, `memory/do-not-contact.md`.

## Then
- Surface a short status: warm leads owed a follow-up, replies to handle, what's due, and a recommended next action.
- Wait for the rep's direction. Do not send anything without explicit APPROVE SEND.

## Standing rules (never violate)
- Send nothing without the rep's explicit APPROVE SEND.
- Run the FULL gauntlet on every message, every channel, every time — automatically.
- TAM-only prospecting: only accounts on this rep's approved target list. Manager-level-and-above personas only.
- Send from the rep's `{{SENDER_EMAIL}}` (`.ai`). The `.com` address is only for rare, fully-customized replies to a warm/inbound prospect.
- Verified contacts only; the rep's own contacts only.
- Read the actual current standard files each time; never rely on cached/summarized versions.
- Quality over volume. Log every send to `MASTER_SENT_LIST.csv` — the send is not complete until the row exists.
- Never take an action visible to coworkers. The rep's AI use is private unless they say otherwise.
