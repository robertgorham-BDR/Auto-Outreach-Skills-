---
name: email-outreach
description: "End-to-end Testsigma email outreach for one contact or a whole batch: source → dedup → Manager+ persona + live research → company anchor → draft to the Testsigma cold-email formula (75-99 words) → QC gauntlet to MQS 9/12 → present for ONE APPROVE SEND → send from the rep's .ai address → MASTER-log. Batch quality equals single-message quality. Runs every gate every time, automatically. Configured from config.json + voice-profile.md."
---

# Email Outreach — the complete channel process

This is ONE skill that owns the entire email motion end to end. It does not hand off to five smaller skills — research, drafting, QA, and sending are all built in, and none of them may be skipped or done lazily, even in a large batch. A batch of 50 is 50 individually-researched messages, not one template mail-merged.

The product you are selling is **Testsigma** — an agentic AI-powered, unified test automation platform: write tests in plain English and AI creates, runs, and heals them, across web, mobile, API, desktop, Salesforce, and SAP. That is the frame every draft anchors a prospect's world to. Never oversell beyond the verified facts in `memory/context/` and the proof points below.

Load first: `skills/_shared/outreach-gauntlet.md`, `skills/_shared/draft-qc-rubric.md`, `memory/context/writing-canon-index.md`, `config.json`.

---

## Phase 0 — Session preflight (MANDATORY, before anything else)
Run `skills/_shared/session-preflight.md`: load and state the approved account universe + ownership rule (scope), the ICP want/don't-want (Manager+ persona, below), and today's number (quota — from the rep's explicit ask, else `config.quota` daily targets / `{{DAILY_EMAILS}}`, minus what's already sent today). Compute how many to oversource to net the target given dedup overlap. Announce the plan, then run continuously to the number. Do not source until this is stated.

## Phase 1 — Intake & source (+ routing)
- The rep names a set of accounts (or says "pull from my target list").
- **TAM-only.** Only prospect accounts on the rep's approved target list (`data/target-accounts.csv` / `{{ASSIGNED_ACCOUNTS_OR_TAM_SLICE}}`). No account surfaced by industry search alone, web research, or vertical-fit inference. Top verticals for fit: SaaS/Tech, FinTech, Retail/E-Commerce, Healthcare/Digital Health, Telecom, Pharma.
- **Batch-intake routing (survey the rep's existing sequences FIRST).** Before drafting, survey the rep's configured sequences (`{{SEQUENCE_IDS}}`) and pull any DUE tasks first. Then dispose each contact by preference order: a sequence with a **manual email step** > a sequence with an **automated-template step** (only if you've read the template and it's acceptable) > a **LinkedIn step** > a **one-off manual email** (least preferred). If routing is genuinely unclear, ask the rep ONE upfront multiple-choice question — never mid-run, never silently default to a one-off.
- Pull contacts scoped to the Testsigma ICP + target list. Apply the **Manager+ persona filter** up front:
  - Title MUST contain one of: **Manager, Director, VP, Vice President, Head, Chief.**
  - Title MUST NOT be a Lead / Senior-IC / Principal / Staff / IC pattern (e.g. "Senior Software Engineering **Manager**" keeps; "Senior Software Engineer" drops).
  - Included personas: QA Manager; Director/VP of QA; Software Engineering Manager; Director/VP Engineering. Secondary (only with buyer intent): VP Engineering / CTO.
  - Excluded regardless of enrichment seniority: SDET, Automation Lead, QA Lead / Lead QA Engineer / Lead QA Analyst, and any IC title.
- **Source wide.** Expect heavy dedup overlap on any account you've worked before (routinely 50-70%). Source at least `config.research.source_width_multiplier`× the target count, and prefer less-worked accounts, so a batch of 10 doesn't collapse to 3 after dedup.
- Output a candidate list. Do NOT enrich or draft yet.

## Phase 2 — Gauntlet A/B: scope, ownership, dedup (per contact)
Run gates 1-7 of the gauntlet for every candidate:
- Account on the target list; assigned to the rep; not another rep's.
- Not in `MASTER_SENT_LIST.csv`; not already enrolled in a sequence; not a saved/prior contact; not on `memory/do-not-contact.md`.
- Drop or route-to-follow-up anyone who fails. Log why.

> **Ordering rule (throughput):** Phase 2 (free screens: Manager+ persona filter + dedup + DNC) runs on the WHOLE oversourced list FIRST. Only Phase-2 survivors reach Phase 3 enrichment + live research. Never enrich or research before screening — that's what wasted effort on contacts that later drop.

## Phase 3 — Gauntlet C: enrich-first, then persona + live research (MANDATORY, per survivor only)
**Enrich first.** Before any deep research, enrich the survivor and confirm a **verified, deliverable email**. Undeliverable / unverifiable contacts are dropped here, never carried into drafting or the send loop.

Then, for every survivor:
- Read the **live** profile (LinkedIn or primary): headline, About, experience, connection degree, recent activity. Catch stale enrichment, wrong-persona, title inflation. Reconcile the live title against the enrichment title (they diverge — trust the **live** one). Confirm the live role still clears the Manager+ persona rule; drop clinical/lab QA, hardware/systems engineers, and other non-software-QA look-alikes even when the enrichment title passed the whitelist.
- **Depth fallback (mandatory):** if the public profile is activity-thin (no About, no recent posts), pull the **Sales Nav lead page** for About + Experience before settling. Company-level-only personalization (MQS personalization = 2) is the signal you skipped this. Only accept a tenure/company-level anchor when Sales Nav depth genuinely comes up empty too — and say so.
- Web-search the company for ONE specific, verified, ideally quantified fact for the opener anchor.
- Write a short evidence note per contact (the fact + its source) into the batch's evidence file under `batches/active/<batch>/` (gitignored — it contains real names). This is what the draft anchors to. **No verified evidence fact → no draft** (drop or flag).
- **Never skip this because the batch is large.** If research is thin for someone, say so honestly and drop them rather than fabricating.

## Phase 4 — Draft to the 4-paragraph standard (load the canon first)
Load `voice-profile.md` + `gold-standards.md` + `qa-rules.md` BEFORE writing. Draft to the house voice: consultative, peer-to-peer, plain. **NO em dashes anywhere** (including the subject line). Short sentences. One CTA. **Ask, don't assert** — open with a diagnostic question grounded in a verified fact about their product/company, never a claim about their feelings, career, or "what they went through." Target **75-99 words**. For each contact:
```
Hi {{FIRST_NAME_OF_PROSPECT}},

[P1] One diagnostic question grounded in the verified fact. Ask, don't assert. No role-recap.

[P2] One line on why that compounds for teams like theirs (flaky tests, slow test creation, or coverage that can't scale).

[P3] One clean named-proof line, rotated per contact and matched to vertical (see proof rotation below).

[P4] One engagement question inviting them to share their situation. Not a meeting ask on a cold Touch 1.

Best,
{{FIRST_NAME}}
```
Apollo's native signature appends the rep's title + address after `Best,\n{{FIRST_NAME}}`. Subject: a specific pain angle at {Company}, no em dash, 4-10 words.

**Proof rotation (Testsigma, external-safe — pick ONE per draft, match to the prospect's pain/vertical, rotate across the batch):**
- **Flaky / brittle tests → AI self-healing.** "Hansard cut regression from 8 weeks to 5." (fits any vertical; strong for SaaS/Tech)
- **Too much time creating / running tests → plain English + parallel execution.** "Medibuddy runs 2,500 tests and cut maintenance about 50%." (fits Healthcare/Digital Health)
- **Can't scale coverage → NLP + AI agent + cross-browser.** "CRED hit 90% regression coverage, 5x faster." (fits FinTech)

Only use the three proof stories above or a public reference-customer name from the rep's enablement docs. Do not invent metrics, customers, or claims.

**Across the batch:** vary the opener SHAPE, the P2 construction, and the CTA so no two drafts share a frame.

## Phase 5 — QC gauntlet (automatic, every batch)
Run `draft-qc-rubric.md` on every draft: MQS ≥9/12, zero hard-rule violations (no em dashes, verified sign-off, one CTA), opener≠CTA, opener-shape variety, context variety, scaffolding-honesty, evidence trace (every concrete claim traces to the evidence file), could-anyone-tell test. An MQS score is INVALID unless `qa-rules.md` + `gold-standards.md` were actually loaded this session — self-scoring from memory is not a QA gate. **Rework anything below bar before the rep sees it.**

## Phase 6 — Present for ONE APPROVE SEND
Show the batch with the mandatory QC table (`# · Name · MQS · opener-frame · weakness-or-clean`) plus each full draft. WAIT for the rep's explicit **APPROVE SEND**. Nothing sends before that. One approval covers the whole batch; after it, the send loop runs autonomously with per-send readback, no further content approval.

## Phase 7 — Send (on approval)
- Create/verify the contact (verified email only). Enroll in the routed sequence per Phase 1 if the flow requires it.
- **Sender rule:** ALL outreach sends from the rep's **`{{SENDER_EMAIL}}`** (their `.ai` address). The `.com` address is only for a rare, direct, fully-customized reply to a warm/inbound prospect (e.g. someone who asked for a demo). Confirm the From field shows `{{SENDER_EMAIL}}` on every send.
- Send via the rep's email tool. **Pre-send readback:** confirm recipient, sender address, subject, and body (paragraph breaks intact) before firing. Verify success. Per-contact failure → log it, mark FAILED, CONTINUE; only a true global blocker halts the run.
- **Log a row to `MASTER_SENT_LIST.csv` per send** (`name,batch,send_date,channel,credits,file,norm`). The send is not done until the row exists. If logging fails, STOP the batch and alert the rep.
- Update the batch tracker.

## Phase 8 — Follow-ups (T2/T3)
- Follow-ups are sent as REPLIES on the original thread, not new cold emails.
- Shorter, a NEW angle/proof, not a rehash (40-70 words). Same gauntlet, same QC.
- A meeting-ask CTA ("what day works?") is allowed on later **outbound** touches (not on the cold Touch 1, and never on inbound). Inbound stays engagement-first.
- Never send a follow-up to anyone who replied, bounced, or opted out — re-check dedup + DNC first.

## Phase 9 — Learn
Run `skills/_shared/learning-loop.md`: log low-scoring patterns, what landed, evidence gaps, any new rules the rep gave.
