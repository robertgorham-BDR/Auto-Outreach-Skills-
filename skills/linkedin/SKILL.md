---
name: linkedin-outreach
description: "End-to-end Testsigma LinkedIn outreach for one contact or a whole batch: source → dedup → Manager+ persona + live-title lock → degree check → draft to the locked short-form formula → QC gauntlet → present for ONE APPROVE SEND → char-for-char readback send → MASTER-log. Covers connection requests, InMail, and DMs. Runs every gate every time. Configured from config.json + voice-profile.md."
---

# LinkedIn Outreach — the complete channel process

ONE skill owning the entire LinkedIn motion end to end (connection requests, InMail, DMs). Research, drafting, QA, and sending are all built in; none may be skipped, even in a large batch.

The product frame is **Testsigma** — AI-powered test automation (write tests in plain English; AI creates, runs, and heals them). That is the only product line every message uses. Persona and voice discipline below are non-negotiable safety gates, not style suggestions.

Load first: `skills/_shared/outreach-gauntlet.md`, `skills/_shared/draft-qc-rubric.md`, `memory/context/writing-canon-index.md`, `config.json`.

---

## Phase 0 — Session preflight (MANDATORY, before anything else)
Run `skills/_shared/session-preflight.md`: state the approved account universe + ownership rule, the ICP want/don't-want (Manager+ persona, below), and today's LinkedIn number (from the rep's ask, else `config.quota.daily_activity_targets.linkedin_requests` / `{{DAILY_LINKEDIN}}`, minus what's already sent today). Oversource for degree-drops + dedup. Announce the plan, then run to the number.

## Phase 1 — Intake & source
Rep names accounts (or "pull from my target list"). **TAM-only** — candidate accounts come only from the rep's approved target list (`data/target-accounts.csv` / `{{ASSIGNED_ACCOUNTS_OR_TAM_SLICE}}`), never from vertical-fit inference or web research. Apply the **Manager+ persona filter**:
- Title MUST contain: **Manager, Director, VP, Vice President, Head, or Chief** — AND MUST NOT be a Lead / Senior-IC / Principal / Staff / IC pattern.
- Keep: QA Manager; Director/VP of QA; Software Engineering Manager; Director/VP Engineering. Secondary (buyer intent only): VP Engineering / CTO. Drop: SDET, Automation Lead, QA Lead, and any IC title.
**Source wide** (≥ `config.research.source_width_multiplier`×) and prefer less-worked accounts — dedup overlap on worked accounts routinely runs 50-70%.

## Phase 2 — Dedup (per contact)
Gates 4-7: not in `MASTER_SENT_LIST.csv`, not already enrolled/messaged, not on `memory/do-not-contact.md`. Drop matches.

## Phase 3 — Persona + LIVE-TITLE LOCK (MANDATORY, main context, per contact)
- Capture the person's **live public profile** (≤24h before send): current-role title verbatim, tenure, connection degree, connections/followers, recent activity (verbatim, or "no recent posts").
- **Judge persona on the LIVE headline, not enrichment.** If the live headline is not a Manager+ software-QA / QE / engineering role, DROP — the enrichment title is not trusted (it routinely mislabels clinical/lab QA, hardware/systems engineers, TPMs, and IC roles as "QA Manager").
- The draft's hook must quote the **live** title verbatim (or a documented faithful derivation) — enrichment/cached data is NOT an acceptable source for the live-title field. Persist the capture to a per-contact evidence file under `batches/active/<batch>/evidence-linkedin/<slug>.md` (gitignored — evidence contains real names and never gets committed). Required non-empty fields: `connection_degree`, `live_headline` (verbatim), `connections`, `followers`, `recent_activity` (verbatim or "no recent posts"), `evidence_quote_for_hook`.
- **Reconcile live title vs enrichment title** — they diverge (e.g. enrichment "VP of Engineering" vs live "VP, Platform Engineering"); the live one is source of truth and must be what the hook quotes.
- **Wrong-persona / left-company / title-inflation checks** apply here — drop anyone who fails.
- **Never delegate this capture to a subagent** and never fabricate profile facts. The capture runs in main context. If a capture fails, retry, then drop the candidate rather than guessing. Do a name-match check per capture (page name == intended candidate) to catch stale/wrong slugs.

## Phase 4 — Degree check → route + deliverability floor
- **1st-degree** → route to a DM (don't spend a connection request / InMail credit on an existing connection).
- **2nd / 3rd-degree** → connection request or InMail.
- **Deliverability floor:** drop candidates with connections < 20 AND followers < 20 (near-guaranteed LinkedIn-side block / wasted credit).

## Phase 5 — Draft to the locked formula (load the canon first)
Load the canon BEFORE writing. Connection request / InMail body — ONE short-form template, variable swaps only:
```
Hi {First}, I'm at Testsigma, AI-powered test automation, and I connect with {dept} to share what we're building. Your {hook} is what caught my attention. Happy to connect if that sounds worthwhile. {{FIRST_NAME}}
```
- `{dept}` ∈ { QA leaders | engineering leaders | automation leaders | QE leaders }, matched to the contact's title tier.
- `{hook}` = the substantive anchor from the **live** evidence (current role + tenure, a recent-activity quote, an About-section AI/agentic anchor, or a distinctive career chronology).
- **229-278 characters, NO em dashes, NO question marks**, no product name-drops beyond the one Testsigma frame. `{{FIRST_NAME}}` is inline at the end of the paragraph (not on its own line, not "- {{FIRST_NAME}}", not an em-dash sign-off).
- **InMail adds a subject** = the `{hook}` clause, leading capital, truncated to ~60 chars. No em dashes, no question marks, no proof-point name-drops.
- **Vary the hook line across the batch** so no two messages are structurally identical.
- **Activity-hook linter:** any "your take / your post / your work / hands-on / congrats" hook must trace to a VERBATIM quote in the evidence file. No quote → rework to a role/tenure/company anchor or drop. "No recent posts" profiles may use ONLY role/tenure hooks. Do not invent creative formats — every message uses this template.

## Phase 6 — QC gauntlet (automatic)
Run `draft-qc-rubric.md` adapted for short-form: hook traces to a verbatim string in the live capture, character range 229-278, zero em dashes / zero question marks, no two drafts structurally identical, could-anyone-tell test. Rework below-bar before presenting.

## Phase 7 — Present for ONE APPROVE SEND
Batch table: `# · Name · live-title (captured) · degree · hook · evidence-file path · clean/weakness` + each full message. No blanket "verified" header — show per-row traceability. WAIT for explicit **APPROVE SEND**.

## Phase 8 — Send (on approval) — char-for-char readback
The ONLY text that enters the invite/message box is the EXACT approved message from the tracker. Never compose, rewrite, or "improve" at send time. Never read the profile again to regenerate personalization mid-send.

**⛔ JS-only connection-request sending is UNSAFE (field-proven) and BANNED on public profiles.** LinkedIn's invite modal ignores synthetic JS clicks (React portal), the "Add a note" box is a **closed shadow DOM** (invisible to querySelector/form_input), and generic selectors match the sidebar "people you may know" Connect buttons — a **wrong-recipient** failure (a live run grabbed the sidebar's "Invite <someone else>" on the target's page). The safe procedure:
- **Enter via the Sales Nav lead page / direct Sales Nav search URL** (no suggestion sidebar → wrong-recipient risk structurally eliminated). Verify exactly-1 result vs the tracker. Use the **free Connect action** — never "Message" from Sales Nav (that's a paid InMail).
- Drive the note with a **real-mouse-click flow**: screenshot → coordinate-click the TOP-CARD Connect (overflow "..." → Connect) → in-modal recipient-NAME check → click the note field to focus → type via the computer/keyboard tool → readback → Send.
- **Test-and-lock the flow on 1-2 contacts** before running any batch through it.

1. Extract the exact approved text from the tracker (programmatic read).
2. Enter the note via the real-mouse flow above.
3. Read back the box content.
4. Compare **character-for-character** against the tracker source.
5. Only click Send if they match exactly. On mismatch: clear, re-extract, re-inject.
6. For connection requests: check for an existing "Pending" state first and skip if present.
7. Dual-signal verify per send (modal gone + zero Connect items in DOM). Watch for a "Free to Open Profile" badge — that send completes successfully WITHOUT a credit decrement (success + free, not a failure).
- **Log a row to `MASTER_SENT_LIST.csv` per send.** Update the tracker. Per-contact failure → log, mark FAILED, continue; only a true global blocker halts.

## Phase 9 — Accept/reply sweep + learn
- Sweep for accepted requests and replies; route warm ones to the reply workflow.
- Run `skills/_shared/learning-loop.md`.
