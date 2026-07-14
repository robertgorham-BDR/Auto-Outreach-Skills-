# Build-a-batch prompt — the daily driver

> Paste this to your agent to run a full Testsigma outreach batch end to end. Swap in your channel and accounts. Your ICP, proof points, house voice, and sender are already baked in — the agent reads them from the kit.

```
Build me a {email | linkedin | call} batch of {N} for these accounts: {list, or "pull from my
assigned TAM slice in data/target-accounts.csv, tier HIGH"}.

Run the full process end to end without stopping for me until the drafts are ready:
- Route first: survey my existing Apollo sequences and dispose each contact in preference order
  (a sequence with a manual email step > a sequence with an automated-template step > a LinkedIn
  step > a one-off manual email). If routing is unclear, ask me ONE bundled multiple-choice
  question upfront, then continue.
- Source contacts scoped to the Testsigma persona lock (Manager-level and above: QA Manager,
  Director/VP QA, Software Engineering Manager, Director/VP Engineering; exclude Lead/Senior IC/
  Staff/Principal-IC and wrong-persona traps) and my assigned accounts only. Source 3-4x the
  target so dedup shrinkage doesn't collapse the batch.
- Dedup against MASTER_SENT_LIST.csv, my active Apollo sequences, and memory/do-not-contact.md.
- Enrich first and keep only verified emails. Drop undeliverable or duplicate contacts now,
  before they reach the send loop.
- For every survivor, do the mandatory research: read their LIVE LinkedIn profile (judge persona
  on the live headline, not enrichment data) and web-search their company for one specific,
  verified fact for the opener. Do not skip this because it's a batch. If research is thin for
  someone, tell me and drop them — never fabricate a claim.
- Load my writing canon (memory/context/voice-profile.md + gold-standards.md + qa-rules.md)
  BEFORE drafting.
- Draft each to the house voice: a diagnostic question on a verified fact as the opener, one
  named Testsigma proof line (Hansard 8->5 weeks, Medibuddy 2,500 tests ~50% maintenance cut,
  or CRED 90% coverage 5x faster — matched to their vertical, one per message), an engagement
  CTA, no em dashes, 75-99 words, "Best," + my first name. Vary opener shape / context / CTA
  across the batch — no shared skeleton.
- For LinkedIn: capture one live evidence file per candidate in main context, 2nd/3rd-degree
  only, every activity hook traced to a verbatim quote or dropped.
- Run the QC gauntlet automatically. Rework anything under 9/12 before showing me.

Then present the batch with the QC table (# · name · account · route · MQS · opener-frame ·
weakness/clean) plus each full draft, and WAIT. Send nothing until I say "APPROVE SEND." On
approval, send from my .ai address, verify recipient/subject/body per contact, run to completion,
and log every send to MASTER_SENT_LIST.csv.
```
