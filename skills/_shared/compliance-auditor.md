# The Compliance Auditor — independent, unbiased pre-send review

The team that *builds* a batch (the sourcing, research, drafting, and orchestration agents) should not be the final word on whether it's fit to send. This function is a **separate, unbiased reviewer** — think internal compliance / QA-sign-off / a fair-but-critical editor — that inspects finished Testsigma BDR outreach as if the rep themselves were reviewing it, looking for the errors a demanding rep looks for. It runs BEFORE the pre-send flight check and before the rep's APPROVE SEND.

## How to run it so it's genuinely unbiased
- **Use fresh reviewer agents that did NOT write the drafts.** Give them only the drafts + the rubric + the evidence, not the drafters' rationale. An agent grading its own work is not a review.
- **Default stance: skeptical but fair.** The reviewer's job is to catch problems, not to rubber-stamp. But it flags real defects, not stylistic nitpicks — it must justify every FAIL with the specific rule and the offending text.
- **Every finding cites the rule + the exact text.** No vague "feels off."

## The audit rubric (each draft must pass all applicable checks)

### 1. Channel-fit (a draft must sound like its own channel)
- **Email is not a LinkedIn message and vice versa.** A cold email follows the 4-paragraph C1 (question → context → named proof → engagement CTA). A LinkedIn connection request follows the short locked CR formula (intro + one signal line + soft close, no question mark, no proof-point name-drop, under ~300 chars). If an "email" reads like a CR (too short, no proof) or a "CR" reads like an email (has a proof point, a question, over length) → FAIL.

### 2. Touch-fit (a T1 must not sound like a T2/T3)
- **T1 (cold open):** no "circling back", "following up", "just wanted to bump this", or any reference to prior contact. It must read as a first touch.
- **T2/T3 (follow-up):** must reference the prior touch and bring a NEW angle; must NOT re-introduce from scratch. If a follow-up reads like a cold open, or a cold open references a prior message that didn't happen → FAIL.

### 3. Formula compliance (per channel) — check the LITERAL text, whitespace included
- **Composition/whitespace:** an email must be four short paragraphs with actual blank lines between them (never one run-on block), sign-off on its own lines (`Best,` then `{{FIRST_NAME}}`). Audit the literal stored text — content that is "logically 4 parts" but stored as a single block FAILS, because it will paste as a wall of text. A CR must be a single short block. This check is on formatting, not meaning.
- Email: 4 paragraphs; 75-99 words; opener is a question on a verified fact; one named proof; engagement CTA (a "what day works" style ask for OUTBOUND only, never on inbound); correct sign-off; no em dashes; ~2 question marks.
- CR: locked formula, char range, no em dash, no question mark, no product name-drops.
- Any hard-rule violation → FAIL.

### 4. Research traceability (no drift into fabrication)
- Every concrete claim (company fact, role, activity) traces to the evidence file / verified capture. A claim with no evidence → FAIL. An "I saw your post" style claim with no matching quoted activity → FAIL. (This is the anti-drift check.)
- Named proof points must be a Testsigma-approved reference story (e.g. Hansard, Medibuddy, CRED) and never an invented customer or metric.
- The person's employer must be currently confirmed (no stale/departed employer — the open-to-work gate).

### 5. Cross-draft distinctiveness (no template drift across a batch)
- No two drafts may be swappable by changing only the company name. Opener frames must vary across the batch; the context line must not repeat verbatim; the personalization must live in the opener/context, not just the company noun.
- **Same-company collision (hard fail):** two recipients AT THE SAME COMPANY must never get the same proof point + the same closing CTA. Colleagues compare inboxes. Every company's contacts in a run must each carry a DISTINCT proof/CTA.
- **Audit ACROSS batches, not just within one.** Per-wave "all distinct" checks miss clones that only collide across waves. Run the distinctiveness check over the whole day's output.
- **Proof/CTA pool must exceed the run size logic:** if you rotate N proof+CTA pairs across M drafts with M > N, verbatim repeats are guaranteed — so decouple the CTA from the proof (a proof can pair with more than one CTA) and widen the proof library before large runs. A fixed {frame→proof→CTA} triple reused 3-5× is the classic drift signature.

### 6. Drift-over-time (batch N vs the standard)
- Compare the newest batch against a known-good reference batch. Has the voice, structure, or proof discipline drifted? Are openers getting formulaic? Flag creeping degradation before it becomes the norm.

### 7. Persona + scope sanity
- Recipient matches the ICP — Manager-level and above (QA Manager, Director/VP of QA, Software Engineering Manager, Director/VP Engineering), not an excluded Lead/Senior-IC/Staff/Principal-IC title and not a wrong-persona trap (clinical/lab QA, hardware/mechanical, defense/systems, or compliance/audit QA when you sell software test automation). The account is in the approved TAM universe. Off-persona or off-scope → FAIL (or FLAG for the rep's call if borderline).

## Output
A verdict per draft: **PASS / REWORK / DROP**, each FAIL with the rule number + the offending text + a concrete fix. Plus a batch-level summary: counts, the drift assessment, and the top systemic issue to fix in the skill (feeds `learning-loop.md`).

## After the audit
- **REWORK items are fixed automatically** (the rep does not need to approve a rewrite — quality is the standing bar), then re-audited.
- **DROP items** are removed with a logged reason.
- Only a batch where every remaining draft is PASS proceeds to the pre-send flight check and the rep's APPROVE SEND.
