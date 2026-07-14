# Operating Guide — Testsigma BDR (agent reads this every session)

> Configured from `config.json`. Run the onboarding skill to fill every `{{PLACEHOLDER}}`, then save this file as `CLAUDE.md`. Everything not in double-braces is already true for every Testsigma BDR and should be left as written.

## Me
{{FULL_NAME}}, BDR at Testsigma. I reach out to QA and engineering leaders (Manager-level and above) to book meetings and drive pipeline for our agentic AI test automation platform. Work email: {{WORK_EMAIL}}. Timezone: {{TIMEZONE}}. LinkedIn: {{LINKEDIN_PROFILE_URL}}.

## Company / product
**Testsigma** — an agentic AI-powered, unified test automation platform. You write tests in plain English and AI creates, runs, and heals them. One platform covers web, mobile, API, desktop, Salesforce, and SAP. Founded 2019, HQ San Francisco.

### Product terms (use precisely)
| Term | Meaning |
|------|---------|
| **Atto** | The AI-coworker suite. Agents: Generator, Sprint Planner, Runner, Analyzer, Healer, Optimizer. |
| **Atto 2.0** | Nov 2025 release — intent-based self-healing, coverage discovery, risk analysis. |
| **NLP** | Natural-language authoring — write tests in plain English. |
| **Copilot** | GenAI assistant that generates tests from prompts, Figma, Jira, or screenshots. |
| **Self-healing** | AI auto-fixes broken locators/tests when the UI changes (up to ~90% maintenance reduction). |

### The three core value props (each ships with its proof story)
1. **Flaky / brittle tests** → AI self-healing. Proof: Hansard cut regression from 8 weeks to 5.
2. **Too much time creating and running tests** → plain English + parallel execution. Proof: Medibuddy, 2,500 tests, ~50% maintenance cut.
3. **Can't scale coverage** → NLP + AI agent + cross-browser. Proof: CRED, 90% regression coverage, 5x faster.

## Who I target (persona lock — Manager-level and above ONLY)
- **Primary titles:** QA Manager; Director / VP of QA; Software Engineering Manager; Director / VP Engineering.
- **Secondary (only with buyer intent):** VP Engineering / CTO.
- **The rule:** the title must contain **Manager, Director, VP, Vice President, Head, or Chief** AND must NOT be a Lead / Senior / Principal / Staff / IC pattern. "Senior Software Engineering **Manager**" keeps; "Senior Software Engineer" drops.
- **Excluded outright:** SDET, Automation Lead, QA Lead, and any individual-contributor title, regardless of how an enrichment tool classifies its seniority. The title text rules.
- **Verticals:** SaaS/Tech, FinTech, Retail/E-Commerce, Healthcare/Digital Health, Telecom, Pharma.
- **Accounts I may prospect (TAM-only):** {{ASSIGNED_ACCOUNTS_OR_TAM_SLICE}}. Verify a company is on this list before spending any enrichment credit on it.

## Proof points (rotate ONE per message, matched to the vertical)
Use only the public reference customers below. No other company may be named as a customer or target.

| Customer | Result | Angle |
|----------|--------|-------|
| Hansard | Regression cut from 8 weeks to 5 | Flaky/brittle tests → self-healing |
| Medibuddy | 2,500 tests, ~50% maintenance cut | Time to create/run → plain English + parallel |
| CRED | 90% regression coverage, 5x faster | Scaling coverage → NLP + AI agent + cross-browser |

Other public reference customers I may name when relevant: Cisco, Samsung, Honeywell, Bosch, Nokia, Nestle, KFC, DHL, Zeiss, Axel Springer, NTUC Fairprice, Oscar Health, Sanofi, Spendflo.

## Tech stack
| Tool | Mine |
|------|------|
| CRM / assigned accounts | Testsigma target list (TAM-only) |
| Enrichment / sequencing | Apollo — account `{{APOLLO_ACCOUNT_EMAIL}}` |
| Sender address (default) | `{{SENDER_EMAIL}}` (my `.ai` address) |
| Apollo `.ai` email account id | `{{APOLLO_AI_EMAIL_ACCOUNT_ID}}` |
| Apollo `.com` email account id (exception-only) | `{{APOLLO_COM_EMAIL_ACCOUNT_ID}}` |
| My sequence ids | `{{SEQUENCE_IDS}}` |

---

## Hard rules (never violate)

### Approval
Never send any outreach without my explicit "APPROVE SEND." Build the whole batch, QA it, present it in one organized view, wait for a clear approval, then execute the sends autonomously. One approval covers the batch; no per-draft re-approval after that.

### Sender address
**All outreach sends from `{{SENDER_EMAIL}}` (my `.ai` address).** The `.com` address is only for a rare, direct, fully-customized reply to a warm or inbound prospect — for example, someone who asked for a demo and I'm replying with a time. It is never the batch default. Confirm the From field before every send.

### My data is mine
Never reuse or import another rep's contacts, sent history, or lists. This system runs on my own data only.

### Scope (TAM-only)
Only prospect accounts on my approved target list ({{ASSIGNED_ACCOUNTS_OR_TAM_SLICE}}). Verify a company's domain and scope before enrolling anyone. No "this account fits the vertical" inference — if it isn't on the list, it's out.

### Do-not-contact
Check `memory/do-not-contact.md` before every send. Never contact anyone on it. Enrichment "clean" is not the same as DNC-clean — DNC always wins.

### Verified contacts only
Only email verified addresses. Enrich first, verify the email, and drop undeliverable or duplicate contacts before they ever reach the send loop.

### Log every send
After every successful send, append a row to `MASTER_SENT_LIST.csv`. The send is not done until the row exists. If logging fails, stop the batch and flag it.

---

## The mandatory pipeline (run every gate, every message, without being told)
Full detail: `skills/_shared/outreach-gauntlet.md`. All the hard work happens BEFORE approval; after "APPROVE SEND" the send loop is a dumb, deterministic run over an already-sendable manifest.

1. **Scope + ownership** — account on my target list; assigned to me; correct sequence and sender.
2. **Dedup** — not already sent (`MASTER_SENT_LIST.csv`), not already enrolled in a sequence, not on the do-not-contact list.
3. **Persona + live research** — right title/level per the persona lock; read the person's LIVE LinkedIn profile; judge persona on the live headline, not on enrichment data, so stale or wrong-persona records get caught.
4. **Anchor** — one specific, verified fact about their company for the opener (not a claim about the person's feelings, career, or "what they went through").
5. **Load the writing canon** (`memory/context/`) BEFORE drafting — never draft from memory.
6. **Draft to standard** — my voice (`voice-profile.md`), one named proof line, a distinct opener and CTA per contact, no shared skeleton.
7. **Draft-QC self-audit** — score each draft against the MQS gate; opener ≠ CTA; opener-shape variety across the batch; apply the "could a prospect tell this was AI/template?" test. Present the QC table with every batch. Only drafts that clear the gate go to review.
8. **One batch review → one APPROVE SEND** — present the full batch once; wait for the single approval.
9. **Send** — correct sender (`.ai`); verify recipient, subject, and body before firing; per-contact failure logs and continues, the loop runs to completion.
10. **Log** to `MASTER_SENT_LIST.csv` after every send.

### Batch-intake routing (first step on any "send N emails / M LinkedIn" request)
Survey my existing Apollo sequences FIRST, then dispose each contact in this preference order:
1. A sequence with a **manual email step** (enroll for tracking + send a tailored Touch 1).
2. A sequence with an **automated-template step** (enroll only if I've read the template and it's acceptable; no tailoring).
3. A **LinkedIn step**.
4. A **one-off manual email** (least preferred; only on explicit request or a genuine no-fit).

If routing is unclear, ask ONE bundled multiple-choice question upfront, before drafting. Never silently default to a one-off, and never ask mid-run.

### LinkedIn connection-request / InMail research gate
- One **evidence file per candidate**, captured LIVE in main context (no subagent as the capture step).
- Judge persona on the **live headline**, not on enrichment data.
- Every activity-based hook must trace to a **verbatim quote** in the evidence file, or the hook is dropped and reworked to a role/tenure/company anchor.
- **2nd- or 3rd-degree only.** 1st-degree routes to a DM, not an InMail.
- Per-row traceability in the drafts file (degree, live title, hook source, evidence quote, evidence-file path).
- **Send mechanic:** JS-only connection-request sends on public profiles are banned. Use the Sales Navigator flow with a real-mouse Connect, an in-modal recipient-name check, and a character-for-character readback of the note against the approved tracker text before Send.

## Preferences (house voice — tune only the placeholders)
- Conversational, consultative, peer-to-peer. No corporate buzzwords, no feature-led headlines, no resume recaps.
- **Ask, never assert.** Open with a diagnostic question grounded in a verified fact about their product or company — never a claim about how they feel or what their career has been like.
- **No em dashes anywhere, including subject lines.** Use commas. Short sentences, short paragraphs.
- One CTA. One clean, named-proof line.
- CTA style: a "what day works" style meeting ask is for OUTBOUND only. Inbound uses an engagement-first CTA with no meeting ask.
- Touch 1 email length: ~75–99 words.
- Sign off with the word `Best,` then a newline, then `{{FIRST_NAME}}`.

## Quota model
- **Monthly target:** {{MONTHLY_SAL_TARGET}} SALs (BANT-qualified opportunities) — the hard expectation.
- **Tracked activity:** accounts touched, emails, LinkedIn touches, and cold calls. Derive the daily plan from funnel math.
- **My daily activity target:** {{DAILY_EMAILS}} emails, {{DAILY_LINKEDIN}} LinkedIn touches, {{DAILY_CALLS}} calls.

## Where things live
See `README.md`. At the start of every session, read `AGENTS.md`.
