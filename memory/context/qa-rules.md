# QA Rules and Scoring Reference

The scoring gate every outbound message passes before presentation.

> **Load the canon FIRST.** An MQS score is INVALID unless `voice-profile.md` + `gold-standards.md` + this file were actually loaded in the current session. Self-scoring from memory is not a QA gate. Entry point + full load order: `writing-canon-index.md`.

## Message Quality Score (MQS) — 12-point system
Every message scores on 4 dimensions (1-3 each), max 12:
- **Opener clarity** — 3 = specific, insight-driven question on a verified fact; 1 = "I'm reaching out" / role-recap.
- **CTA confidence** — 3 = one clear ask (outbound: a low-friction meeting ask; inbound: a specific engagement question); 1 = permission-style / vague / two asks.
- **Personalization density** — 3 = something only this person would recognize; 1 = name/title/company swap only.
- **Friction (inverted)** — 3 = 75-99 words, one proof, one CTA, clean; 1 = wall of text, bullets, multiple CTAs.

**Thresholds:** 10-12 ready · 9 acceptable · <9 must be reworked. Only ≥9/12 is presented.

## QA gate (mandatory before batch presentation)
1. **Rule-violation scan** against every hard constraint. Any violation = auto-rewrite. Includes:
   - No em dashes anywhere (subject line included).
   - Sign-off is exactly `Best,` then a newline then the rep's first name. No `— Name`, `- Name`, or `Cheers,`.
   - Exactly one CTA; correct CTA type for the channel (outbound meeting ask vs inbound engagement question).
   - Body within word count (75-99 for cold T1).
   - Testsigma named at most once; only external-safe customers cited as proof.
2. **Compute MQS** for every message; show the breakdown.
3. Only **≥9/12** may be presented.
4. **Structural dedup** — no two messages in a batch may be structurally identical; no two openers may share a frame.
5. **Evidence check** — every personalization claim traces to a real research source (live LinkedIn read or a verified company web-anchor). No fabricated hooks.
6. **Angle rotation** — no prospect gets the same angle or the same proof in more than one touch.

## Prospect prioritization (reply-likelihood, not theoretical ICP fit)
- **Boost:** titled leaders in the ICP (Manager-level and above only); companies where personalization-3 is achievable; companies in active transformation/scaling; intent signals.
- **Penalize:** only surface-level personalization possible; roles with no relevant scope; wrong-persona titles (SDET / QA Lead / IC); anything needing >120 words to explain relevance.

## Proof-point rotation
Never use the same proof point twice for the same prospect across a sequence. Match the proof angle (self-healing / velocity / coverage) to the prospect's vertical and pain. The proof set lives in `config.json`; the three external-safe stories are Hansard, Medibuddy, and CRED.

## Observed reply patterns (tune to your own data over time)
| Type | Action |
|------|--------|
| Polite ("thanks") | Follow up with value, not a commitment ask. |
| Positive ("interested") | Book the meeting immediately. Don't over-explain. |
| Negative ("not interested") | Log the objection. Maybe re-engage 60+ days later. |
| Curiosity ("tell me more") | Answer directly, then bridge to a meeting. |
| Referral ("talk to [name]") | Reach out to the referred person immediately. |
| Has tool ("we use X") | Handle the objection with your team's enablement docs: ask about gaps. |
| Timing ("not right now") | Set a reminder; re-engage on a trigger. |
