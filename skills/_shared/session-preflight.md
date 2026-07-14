# Phase 0 — Session Preflight (run FIRST, every long-horizon batch, before any sourcing)

The agent does not touch a single prospect until it has loaded the rep's operating context and computed the day's plan from it. This is what lets a run hit the real number in one pass instead of producing a token sample. All values come from `config.json`.

## Step 0.1 — Load the approved account universe (scope awareness, TAM-only)
State it back explicitly before sourcing:
- The approved account list(s) from `config.scope.target_accounts_file` — the rep's TAM slice + Factor intent + any authorized exception source. Count them. TAM-only: no account is sourced unless it is on an approved list.
- Whether accounts are **shared across reps** (`config.scope.accounts_shared_across_reps`). If yes, every candidate account must pass the **ownership check** (`config.scope.ownership_check`) — assigned to THIS rep, not another. Off-list or not-yours = never sourced.
- Say it out loud: *"Your approved universe is N accounts across [lists]. I will only source people at these accounts, and only ones assigned to you."*

## Step 0.2 — Load the ICP (persona awareness, Manager+ only)
State the target and the anti-target before sourcing:
- **Want to see** (`config.icp`): Manager-level and above only — QA Manager, Director/VP of QA, Software Engineering Manager, Director/VP Engineering (secondary: VP Engineering / CTO only with buyer intent). The title must contain Manager, Director, VP, Vice President, Head, or Chief. Top verticals: SaaS/Tech, FinTech, Retail/E-Commerce, Healthcare/Digital Health, Telecom, Pharma (`include_title_contains` + `seniority_floor` + geos).
- **Do NOT want to see** (`config.icp.exclude_title_patterns` + `exclude_wrong_persona`): the title patterns that drop even when the enrichment tool says otherwise (Lead / Senior-IC / Staff / Principal-IC; e.g. "Senior Software Engineer" drops while "Senior Software Engineering Manager" keeps), and the wrong-persona traps (clinical/lab QA, hardware/mechanical, defense/systems, or compliance/audit QA when you sell software test automation).
- The persona filter is applied at sourcing time AND re-checked against the **live title** during research (enrichment tools mis-classify; the live title text wins).

## Step 0.3 — Compute the number (quota awareness)
Before sourcing, determine today's target — don't wait to be told:
1. **Did the rep specify a quantity in this request?** (e.g. "50 emails and 10 LinkedIn.") If yes, that's the target. "N emails" means N NET-NEW T1s; due follow-up touches are worked in addition and never counted against N.
2. **If not, derive it from `config.quota`:** the `daily_activity_targets` (emails / linkedin_requests / calls) are the default daily number, itself derived by funnel math from the monthly SAL target (`config.quota.monthly_sal_target`). If only a monthly target exists, break it down: monthly ÷ working days = daily; state the weekly breakdown too.
3. **Subtract what's already done today** (grep `MASTER_SENT_LIST.csv` for today's date) → *remaining* target.
4. State the plan: *"Target today: {{DAILY_EMAILS}} emails + {{DAILY_LINKEDIN}} LinkedIn. Already sent today: X. Remaining: Y. Here's how I'll get there."*

## Step 0.4 — Size the run for throughput (the fix for "batch of 3")
Netting the number requires oversourcing, because of dedup overlap:
- **Expected overlap** on worked accounts runs 50-70%. To net `Y` clean contacts, source and screen roughly `Y ÷ (1 − overlap)` × a safety margin (use `config.research.source_width_multiplier`, default 4).
- **Cheap-screens-first ordering (mandatory):** run the FREE screens on the whole oversourced list BEFORE spending any enrichment credit or doing any live research:
  1. Persona/title filter (Phase 0.2 rules — Manager+, no wrong-persona)
  2. MASTER_SENT_LIST dedup grep
  3. Do-not-contact grep
  4. (LinkedIn) connection-degree + deliverability screen
- **Only the survivors** get enrichment (credits) + live research (the expensive, sequential, main-context step). This is the enrich-first discipline: verify email before spending research effort, so 50 is feasible instead of burning research on contacts that drop.
- Budget credits: `survivors ≈ Y`; enrichment cost ≈ `Y` credits. Confirm the rep has the runway.

## Step 0.5 — State the run plan, then execute continuously
Announce the plan in one line, then RUN IT to completion without stopping for content approval mid-run (batch-approval model — the single approval gate is the rep's APPROVE SEND at the very end):
> *"Sourcing ~125 to net 50 clean; free-screening first, then enriching + live-researching the ~50 survivors, drafting to the canon, and self-scoring each to ≥9/12. I'll present the full batch with the QC table for one approval. Nothing sends from `{{SENDER_EMAIL}}` until you say APPROVE SEND."*

If the run is genuinely too large for one session's tool budget, say so **up front** with the honest throughput math (≈1 live capture per clean contact, sequential), and propose the largest complete slice — never silently shrink the number to a token sample.
