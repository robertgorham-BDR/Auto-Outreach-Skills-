# The Outreach Gauntlet — the mandatory end-to-end process every channel runs

> This is the engine underneath every channel skill (email / linkedin / calls) for the Testsigma BDR motion. No message is "ready" until every gate below is checked. The agent runs the FULL gauntlet on every message, every channel, EVERY time — automatically, to standard, so drafts pass on the first review. Never a low-effort pass. This is configured from `config.json` and your `voice-profile.md`.

The gauntlet runs the same whether you're building **one** message or a **batch of fifty**. Batch quality must equal single-message quality — the agent never gets lazy or skips research because the volume is high.

> **Volume, parallelism, and smaller models:** to hit big daily numbers, run the live-research step across parallel subagents under the four mitigations in `parallel-execution-and-limits.md`. That file also defines the **model-awareness / graceful-degradation** rule: if the agent (or its model) can't do everything, it does LESS, never WORSE — fewer fully-verified drafts, never fabricated ones — and reports the honest number. Read it before any volume run.

---

## Phase 0 — Session preflight (run FIRST, before any sourcing)
Before touching a single prospect, load the rep's operating context and compute the day's plan from it — so the run hits the real number in one pass, not a token sample. Full protocol: `skills/_shared/session-preflight.md`. In short:
- **Scope (TAM-only):** state the approved account universe — the rep's TAM slice + Factor intent + any authorized exception source (`config.scope.target_accounts_file`) + ownership rule. Never source off-list or not-yours.
- **ICP (Manager+ only):** state what you WANT (QA Manager, Director/VP of QA, Software Engineering Manager, Director/VP Engineering — Manager-level and above, in Testsigma's top verticals) and what you DON'T (Lead/Senior-IC/Staff/Principal-IC excludes + wrong-persona traps like clinical/lab QA, hardware/mechanical, defense/systems, or compliance/audit QA when you sell software test automation).
- **Quota:** determine today's number — from the rep's explicit ask, else `config.quota` daily targets, minus what's already sent today. "N emails" means N net-new T1s; due follow-up touches are worked in addition, not counted against it.
- **Throughput:** oversource (target ÷ (1 − overlap)), run the FREE screens first, spend enrichment + live research only on survivors.

## A. Scope + ownership (before spending any effort)
1. **Scope:** the account is on your target list (`data/target-accounts.csv`) or an authorized exception source (e.g. an intent list). No off-list accounts.
2. **Ownership:** in your CRM, the account is assigned to you and not actively worked by another rep. Someone else's account = STOP.
3. **Route → sequence/sender (batch-intake routing):** survey the rep's existing sequences FIRST, then dispose each contact by preference — a sequence with a **manual email step** > a sequence with an **automated-template step** > a **LinkedIn step** > a **one-off manual email**. Ask ONE upfront multiple-choice question if routing is unclear. The account's tag maps to the correct sequence and sending address per `config.json` `tech_stack`; the default sending address is the rep's `.ai` (`{{SENDER_EMAIL}}`).

## B. Dedup (drop anyone already worked)
4. **Sent list:** grep `MASTER_SENT_LIST.csv` by name — any prior send on any channel = drop (or route to the correct follow-up touch, not a cold open).
5. **Sequence enrollment:** the contact is not already enrolled in an active sequence (check via your email/sequencing tool).
6. **Saved-contact check:** the contact isn't already saved/owned in a way that means prior outreach. Strict by default.
7. **Do-not-contact:** grep `memory/do-not-contact.md` — drop every match.

## C. Persona + live research (MANDATORY, never skipped, never delegated blind)
8. **Persona lock (Manager+):** the title matches your ICP in `config.json` (seniority floor + included titles) and is NOT an excluded pattern. The title must contain Manager, Director, VP, Vice President, Head, or Chief AND must not be a Lead/Senior/Principal/Staff/IC pattern (e.g. "Senior Software Engineering Manager" keeps; "Senior Software Engineer" drops). Read the *live* title, not just the enrichment tool's cached one.
9. **Live profile read PER CONTACT:** open the person's live LinkedIn (or primary) profile — headline, About, experience, connection degree, recent activity. This catches: left-the-company (stale enrichment), wrong-persona (e.g. clinical/hardware/compliance QA when you sell software test automation), title inflation, and profile/slug mismatches. Enrichment data is necessary but NOT sufficient. **Never skip this, even in a large batch.**
   - **Stale-employer DROP gate:** if the live read shows an "Open to work" badge, a recent departure/layoff post, or any signal the person may have left the company on record, DROP the contact — a company-anchored draft to someone who left is a wrong send. (See `parallel-execution-and-limits.md` §D.)
10. **Company web-search:** find ONE specific, verified, ideally quantified fact about their product/company for the opener anchor (a recent launch, an integration count, a named feature, a scale number, funding/acquisition). No fact → an honest humble anchor, never a generic role-surface filler.

## D. Draft to standard (LOAD THE CANON FIRST — never draft from memory)
11. **Load the writing canon BEFORE writing:** `memory/context/voice-profile.md` (your voice, the source of truth) + `gold-standards.md` + `qa-rules.md` + the channel formula. Entry point: `memory/context/writing-canon-index.md`.
12. **Draft to the channel formula** (email = the 4-paragraph standard: diagnostic question → context → named proof → engagement CTA). The named proof is ONE clean customer outcome from Testsigma's approved reference stories (e.g. Hansard cutting regression from 8 weeks to 5, Medibuddy ~50% maintenance cut across 2,500 tests, CRED 90% regression coverage 5x faster). Vary the opener SHAPE, the context construction, and the CTA across the batch so no two drafts share a frame.
13. **Subject** (email): a specific angle, no em dash.

## E. Draft QC self-audit (MANDATORY every batch — runs AUTOMATICALLY, surfaced to you every time)
This gate is not "when the rep asks." The audit already ran; its table is already in the presentation. Per draft, score it AND name the specific weakness — don't just assert a number.
14. **Score ≥ 9/12 on the MQS rubric** (`draft-qc-rubric.md`), zero hard-rule violations (no em dashes anywhere including the subject; one CTA; sign-off = `Best,` then `{{FIRST_NAME}}`).
15. **Opener ≠ CTA** — the opening question and the closing question must ask different things.
16. **Opener-shape variety across the batch** — list each draft's opener frame; no two may share one.
17. **Context-line variety** — don't reuse the same middle-line construction across drafts.
18. **Scaffolding-honesty** — proof lines and CTAs may repeat by design, so confirm the opener + context are genuinely recipient-specific (traceable to the live research), not just the company name dropped into a template.
19. **The "could-anyone-tell" test** — could a prospect tell this was AI/template? Could two drafts swap company names and still read fine? If yes → rewrite.

**Rework loop:** anything below bar gets reworked BEFORE the batch reaches the rep. Only ≥9/12, all-checks-pass drafts are presented.

**Mandatory presentation artifact:** every batch presentation includes a compact QC table — one row per draft: `# · Name · MQS · opener-frame · one-line weakness-or-"clean"`.

## E.5 Independent compliance audit (before the batch is presented / sent)
After the drafters finish, a SEPARATE unbiased reviewer (`compliance-auditor.md`) — fresh agents that did not write the drafts — audits the batch for channel-fit (email≠CR), touch-fit (T1≠T2/T3), formula compliance, research traceability, cross-draft distinctiveness, drift-over-time, and persona/scope. REWORK items are fixed automatically (quality is the standing bar; the rep doesn't approve a rewrite), DROP items removed. Only an all-PASS batch proceeds.

## F. Send (only after explicit APPROVE SEND + the pre-send flight check)
Run the **pre-send flight check** and, after each send, the **post-send maintenance check** (`preflight-postflight.md`). Pre-flight verifies the rep's explicit APPROVE SEND + audit-pass + re-dedup + DNC + current-employer + verified-email + correct-sender (`.ai`) + character-exact readback before the send fires. Post-flight verifies it landed as intended, logs MASTER, updates trackers, and sweeps for bounces/incidents.

### Legacy send notes
20. Create/verify the contact (verified email only). Enroll in the correct sequence/sender if the flow requires it.
21. Send via your tool from `{{SENDER_EMAIL}}` (the `.ai` default; the `.com` address is only for a rare, direct, fully-customized reply to a warm/inbound prospect). Pre-send readback: confirm recipient, sender address, subject, and body (including paragraph breaks) before the send fires. Verify the send succeeded.
22. **Log a row to `MASTER_SENT_LIST.csv` per send.** The send is NOT done until the row exists.
23. Update the batch tracker / sequence roster.

## Standing rules the agent never needs reminding on
- **Send nothing without the rep's explicit APPROVE SEND.** Build → QA → present → wait → send.
- **Verified contacts only. TAM-only. Your own contacts only** (never another rep's, never an off-list account).
- **Enrich-first:** verify email before spending live-research effort; drop undeliverable/duplicate contacts before they reach the draft stage.
- **Read the actual current standard files every time** — never rely on cached/summarized versions; they drift.
- **Quality over volume** — never send weak work to hit a number. A batch of 50 is 50 individually-researched messages, not one template mail-merged.
