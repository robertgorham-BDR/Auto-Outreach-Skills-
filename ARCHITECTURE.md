# Architecture — how the Testsigma BDR Kit works

This kit turns a fresh clone into a working, agent-driven BDR system a new Testsigma rep can configure to themselves and run in batches at a 9/10 quality bar — on the Testsigma playbook, from their own name and sender, without ever touching anyone else's data.

Three ideas hold it together:

1. **The playbook is baked in; you configure your identity.** The Testsigma product story, ICP/personas, proof points, house voice, verticals, and send-safety pipeline ship pre-loaded in `CLAUDE.md`, `memory/`, and `skills/`. `config.json` holds only what is individual to you — name, `.ai` sender, timezone, Apollo login + email-account IDs, assigned accounts/TAM slice, sequence IDs, quota. Every template reads the playbook plus your config. Fill your config once; the whole kit is running your motion.
2. **The agent does the work; the human approves the send.** Research, enrichment, drafting, the quality gauntlet, and self-scoring all run autonomously. Nothing is shown to the rep until it clears 9/10. The rep's only job is "APPROVE SEND / don't."
3. **Nothing personal ships.** The Testsigma *playbook* is public/marketing-safe and ships in the clear. Contacts, sent history, DNC names, account lists, Apollo/tool IDs, webhooks, and secrets are all gitignored or never committed. A rep brings their own.

---

## Repo layout (flow-for-agents)

```
bdr-starter-kit/
├── README.md                 # front door: what this is, who it's for, quick start
├── SETUP.md                  # per-rep step-by-step (identity + tools)
├── ARCHITECTURE.md           # this file — the mental model
├── config.example.json       # THE per-rep config (copy → config.json, fill placeholders)
├── .gitignore                # PII safety net (config + data files never commit)
│
├── CLAUDE.template.md        # the brain — Testsigma playbook + hard rules, read every session
├── AGENTS.template.md        # session-start protocol (what to load, in order)
│
├── prompts/                  # copy-paste prompts a rep hands their agent
│   ├── onboarding-prompt.md      # "set this kit up for me" (run once)
│   ├── build-batch-prompt.md     # "build me a batch of N" (the daily driver)
│   └── run-my-day-prompt.md      # morning: replies, follow-ups, batch, calls
│
├── skills/                   # the agent's capabilities, categorized by channel
│   ├── onboarding/               # interviews the rep for identity + tools, fills config
│   ├── _shared/                  # cross-channel engine
│   │   ├── outreach-gauntlet.md      # the full gate sequence (scope→…→log)
│   │   ├── draft-qc-rubric.md        # the 9/10 scoring gate
│   │   └── learning-loop.md          # self-improve after each batch
│   ├── email/                    # email-channel skills (build batch, T2, send, verify)
│   ├── linkedin/                 # LinkedIn skills (connection batch, InMail, DM)
│   ├── calls/                    # call prep, live cues, post-call follow-up
│   └── ops/                      # dedup, master-logging, analytics, dashboards
│
├── memory/                   # the Testsigma methodology (marketing-safe, no personal data)
│   ├── context/                  # the writing canon
│   │   ├── voice-profile.md          # the Testsigma house voice (consultative, no em dashes)
│   │   ├── qa-rules.md               # the MQS 12-point rubric
│   │   ├── gold-standards.md         # structure of a great Testsigma message
│   │   └── writing-canon-index.md    # load-order entry point
│   ├── sops/                     # per-channel SOPs (email, linkedin, calls)
│   └── playbooks/                # dedup, follow-up cadence, warm-lead handling
│
├── sequences/
│   └── _TEMPLATE-sequence/       # blank sequence scaffold (readme+prospect+draft+send)
│
├── data/
│   └── target-accounts.example.csv   # header only — rep adds their assigned accounts
│
├── analytics/
│   └── db_init.sql               # schema only — no rows
│
└── batches/
    └── active/.gitkeep           # where working batches land (gitignored)
```

**Categorization is by channel** (email / linkedin / calls) with a shared engine underneath. Each channel folder is self-contained: its SOP, its templates, its skills — all calling the same `_shared/` gauntlet and QC rubric so quality is identical across channels.

---

## The autonomous batch engine (the flow every channel runs)

A rep says *"build me an email batch for these 15 accounts."* The agent runs this without further prompting:

```
  INTAKE      Rep names a channel + a set of accounts (or "pull from my target list").
    │         Agent surveys the rep's sequences first, then routes each contact.
  SOURCE      Pull contacts scoped to the Testsigma persona filter + target-accounts.csv.
    │
  ┌─ GAUNTLET (per contact, fully autonomous) ───────────────────────────┐
  │  1 Scope + ownership   account in list, assigned to rep, .ai sender   │
  │  2 Dedup               not in MASTER, not enrolled, not on DNC        │
  │  3 Persona + live      read live LinkedIn, judge on live headline     │
  │  4 Anchor              one specific verified company fact             │
  │  5 Load canon          voice-profile + qa-rules BEFORE drafting       │
  │  6 Draft               house voice, one named proof, distinct opener  │
  │  7 Self-QC             score vs 9/10 rubric; auto-remediate if below  │
  └──────────────────────────────────────────────────────────────────────┘
    │            (loop until every draft in the batch is ≥ 9/10)
  PRESENT     One table: contact, hook, draft, QC score, evidence trace.
    │         ONLY ≥9/10 drafts shown. Agent WAITS. Nothing sends yet.
    │
  ── APPROVAL ──  Rep reviews, says "APPROVE SEND" (or edits, or drops).
    │
  SEND        Execute via Apollo from the rep's .ai sender. Per-send readback verify.
    │
  LOG         Append a row to MASTER_SENT_LIST per send. Not done till logged.
    │
  LEARN       Update the learning loop: what scored low, what to reuse.
```

The key promises this delivers on:
- **Batches, not one-at-a-time.** The gauntlet runs across the whole set; the rep gets one review, one approval.
- **9/10 before a human sees it.** The self-QC gate remediates or drops weak drafts automatically. The rep never wastes time editing sub-standard work.
- **On-message from day one.** Every step reads the baked-in Testsigma playbook + the rep's `config.json`, so the same engine produces the correct persona targeting, the right proof story, and the house voice — from *their* name and sender.
- **Safe by construction.** Approval gate before send; DNC + dedup before draft; MASTER log after send.

---

## The LinkedIn research gate (why CR/InMail is its own discipline)

LinkedIn connection-request and InMail work runs a stricter gate than email:
- One **evidence file per candidate**, captured live in the main context (never delegated/summarized).
- Persona is judged on the **live headline**, not enrichment data.
- Every activity-based hook must trace to a **verbatim quote** or it is dropped.
- **2nd/3rd-degree only**, with per-row traceability at review.
- **JS-only sends on public profiles are banned** — sends go through the Sales Navigator real-mouse flow with a character-for-character readback before the invite is sent.

---

## How a new rep gets from zero to running

1. Use this template on GitHub (into their work account) and clone into a desktop folder.
2. Open their agent in the folder and paste `prompts/onboarding-prompt.md`.
3. The onboarding skill interviews them for identity + tools → fills `config.json` → replaces every `{{placeholder}}` → helps connect Apollo / email / LinkedIn.
4. They add their assigned accounts to `data/target-accounts.csv`.
5. They paste `prompts/build-batch-prompt.md` and start running batches.

From there the daily loop is: run-my-day → review the batch → APPROVE SEND → the agent sends and logs.

---

## The PII firewall (what never leaves the rep)

| Never committed | How it's blocked |
|---|---|
| Filled-in config (`config.json`) | gitignored |
| Contacts / sent history / warm leads / call log / pipeline | gitignored; templates ship empty |
| DNC names | gitignored; ships empty |
| Target account list | gitignored; only an example header ships |
| Apollo/tool IDs, sequence/campaign IDs, webhooks, API keys | live in `config.json` / `.env` only, both gitignored |

The Testsigma playbook (product facts, personas, proof stories, voice) is public/marketing-safe and ships in the clear — it contains no rep-specific or real-person data. Before any push, a PII scan greps the whole tree for names, emails, phone numbers, and known tool-ID patterns. Zero hits is the gate.
