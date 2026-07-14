# Messaging Standards — the hard rules (generic craft, no personal data)

Hard-won rules for Testsigma outbound that lands, distilled from analyzing thousands of real messages (replies vs no-replies). None of this is specific to any one rep — it's the craft. Load it alongside `voice-profile.md`.

## The non-negotiables (memorize these)
- **NO em dashes anywhere, including subject lines.** They read as AI-generated. Commas or short hyphens only.
- **One CTA per message.** Never two asks.
- **Ask, don't assert.** Open with a diagnostic QUESTION grounded in a specific verified fact about their product/company — never a claim about their pain, feelings, or career.
- **Cold email body = 75-99 words** (target ~85); 120 absolute max. Follow-ups shorter (40-70).
- **Sign-off is exactly:**
  ```
  Best,
  {{FIRST_NAME}}
  ```
  The word `Best,` then a newline then the rep's first name. Never `— Name`, `- Name`, or `Cheers,`.
- **Meeting-ask CTAs are OUTBOUND-only.** A "what day works" close is the house default for cold outbound. Inbound never gets a meeting ask — it gets an engagement question, because the person already came to you.
- **Sender = the rep's `{{SENDER_EMAIL}}` (their `.ai` address)** for all outreach. The `.com` address is only for a rare, direct, fully-customized reply to a warm/inbound prospect.

## The negative-signal openers (these measurably kill replies)
- **"I'm reaching out" / "wanted to connect" / "I saw" / "I noticed"** — the single strongest negative signal in the data. Never open this way.
- **Role-at-company as the opener** ("Seeing that you're the [Title] at [Company]") — present in the overwhelming majority of *failed* messages. Banned.
- **Resume recap** — referencing their tenure, career history, or "you came up through X." It reads as templated research, not interest.
- **"Based on your profile"** or any variant that reveals you were profile-mining.

## What a strong opener does instead
- Asks **one diagnostic question** grounded in a **specific, verified, ideally quantified fact about their product or company** — a recent launch, an integration count, a named feature, a scale number, a funding/acquisition event.
- **Asks, never asserts.** Never declare their pain as fact ("your team must be drowning in manual tests"). Ask so they self-identify.
- If you don't have a specific fact, **web-search the company** for one. No fact → an honest, humble anchor — never a generic role-surface filler.

## Content rules
- **No feature-led headline.** Leading with Testsigma's marquee feature (agentic AI, plain-English tests, self-healing) measurably loses. Lead with *their* world.
- **No feature dumping, no credential dumping.** Don't list capabilities, stats, investors, or logos.
- **One named proof point with a hard number**, framed as what the *customer* achieved, not what Testsigma does. Use one of the three external-safe stories:
  - Self-healing / flaky tests → "Hansard cut regression from 8 weeks to 5."
  - Time creating/running tests → "Medibuddy ran 2,500 tests and cut maintenance ~50%."
  - Scaling coverage → "CRED hit 90% regression coverage, 5x faster."
  - Other nameable reference customers: Cisco, Samsung, Honeywell, Bosch, Nokia, Nestle, KFC, DHL, Zeiss, Axel Springer, NTUC Fairprice, Oscar Health, Sanofi, Spendflo. No other company may be cited as a customer.
- **Never vague** ("significant improvement"). Always the number.
- **Name Testsigma once**, in the proof line only.

## CTA rules
- **Outbound cold email CTA = one clear, low-friction meeting ask** ("what day works next week for a quick look?"). This is the house default and the top performer for TAM outbound.
- **Inbound CTA = an engagement question** that invites them to share their current situation. Never a meeting ask.
- No **permission-based** CTAs ("would it be unreasonable," "happy to share if helpful").
- No **easy-outs** ("no worries if not," "feel free to ignore").
- No **self-serving** framing ("I'd love to show you").

## Structure & length
- **Four short paragraphs**, blank lines between: opener question / context / named proof / CTA. Never one dense block — the whitespace is what makes it read like a human thought.
- Cold email body **75-99 words** (target ~85); 120 absolute max. Follow-ups shorter (40-70).
- **No em dashes** (subject line included). Commas over semicolons. Contractions fine. ~8th-grade reading level.
- Two question marks is the ceiling (opener + an inbound CTA); don't force more.

## The scoring gate (MQS, 12 pts)
Opener clarity + CTA confidence + personalization density + friction (inverted), 1-3 each. Present only ≥ 9/12. Full rubric: `qa-rules.md`.

## Personalization tiers (be honest about which you hit)
- **Tier 3 (best):** something only THIS person would recognize — a post they wrote, a project, a specific product move.
- **Tier 2:** company-specific and current, but any peer in that role could receive it. *This is the common ceiling for senior QA/Eng leaders whose profiles are activity-thin — accept it honestly rather than fabricating a personal hook.*
- **Tier 1 (fail):** name/title/company swap only. Indistinguishable from a template.

## The anti-template tests (run before anything goes out)
1. **Could a prospect tell this was AI or a template?** If yes, rewrite.
2. **Could two drafts in the batch swap company names and still read fine?** If yes, they're not personalized — rewrite.
3. **Opener ≠ CTA:** the opening question and the closing ask must be about different things.
4. **Opener-shape variety:** across a batch, no two openers share a frame (grow-faster-than-cover / keep-stable-as-ship / test-enough-to-trust / consistency-across-surfaces / maintenance-vs-build / how-long-to-trust).
5. **Scaffolding honesty:** proof lines and CTAs may repeat across a batch by design — so the *opener + context* must carry the personalization and be traceable to real evidence, not just a company name dropped into a template.

## Proof-point rotation
Never reuse the same proof for the same prospect across a sequence. Match the proof's angle (coverage / maintenance / velocity / scale) to the prospect's vertical and pain. Keep the proof set in `config.json`.

## Timing
Afternoon send window tends to win; avoid evening sends. Persistence matters — a meaningful share of replies come after the 3rd touch, so cadence with *varied angles* beats a single blast.

## Field-validated cohort note
For senior engineering/QA leaders (Director/VP Eng, QA Manager), public LinkedIn profiles are usually header-only — no About, no activity. For that cohort, personalization comes from the **verified company web-anchor** plus **Sales Nav lead-page depth**, not from public-profile activity. Don't fabricate a personal hook that isn't there; a strong company anchor at Tier 2 is the honest, high-quality play.
