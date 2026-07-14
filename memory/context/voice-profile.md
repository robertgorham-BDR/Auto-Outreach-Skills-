# Voice Profile — the Testsigma BDR house voice

> This file is the SINGLE SOURCE OF TRUTH for how outbound sounds. It is the **Testsigma house voice** — already set, baked in from what we sell and how we win replies. Every draft is written against this file and checked against it after. The **structural** rules are craft (never change them). The house **tone** below is the default for every rep. A rep may lightly personalize the clearly-marked **OPTIONAL per-rep calibration** section during onboarding, but the house voice always wins conflicts.

---

## What we sell (so the voice is grounded, not generic)
Testsigma is an agentic AI-powered, unified test automation platform. Write tests in plain English; AI creates, runs, and heals them. One platform covers web, mobile, API, desktop, Salesforce, and SAP. Founded 2019, HQ San Francisco. The AI-coworker suite is called Atto (agents for generating, planning, running, analyzing, healing, and optimizing tests); self-healing auto-fixes broken locators when the UI changes (up to ~90% maintenance reduction).

You do not pitch this in the opener. You lead with the prospect's world and ask about it. The product shows up once, as one clean proof line.

### The three things we solve (and the one proof story each)
| Their pain | What we do | Proof line (external-safe) |
|---|---|---|
| Flaky / brittle tests | AI self-healing | Hansard cut regression from 8 weeks to 5. |
| Too much time creating / running tests | Plain English + parallel execution | Medibuddy ran 2,500 tests and cut maintenance ~50%. |
| Can't scale coverage | NLP + AI agent + cross-browser | CRED hit 90% regression coverage, 5x faster. |

Other public reference customers you may name (the ONLY customer names allowed): Cisco, Samsung, Honeywell, Bosch, Nokia, Nestle, KFC, DHL, Zeiss, Axel Springer, NTUC Fairprice, Oscar Health, Sanofi, Spendflo. Never invent a customer.

## Who we write to (personas — Manager-level and above only)
QA Manager · Director/VP of QA · Software Engineering Manager · Director/VP Engineering. Secondary (only with buyer intent): VP Engineering / CTO. Rule: the title must contain Manager, Director, VP, Vice President, Head, or Chief AND must not be a Lead/Senior/Principal/Staff/IC pattern ("Senior Software Engineering Manager" keeps; "Senior Software Engineer" drops). Exclude SDET / Automation Lead / QA Lead / individual-contributor titles. Top verticals: SaaS/Tech, FinTech, Retail/E-Commerce, Healthcare/Digital Health, Telecom, Pharma.

---

## The house voice, in one line
Consultative, peer-to-peer, plain. Talk like an engineer who understands testing and is genuinely curious about how *their* team ships, not a salesperson reading a script. Short sentences. One thought per message. Ask about their world instead of reciting it back to them.

## The self-test
Before any message: "Could a prospect tell this was written by AI or a template?" If yes, rewrite. A good message reads like one coherent thought from someone who understands their world.

---

## Structural hard rules (KEEP THESE — they're craft, not personality)

### Formatting
- **NO em dashes.** Anywhere. Including subject lines. Use commas or short hyphens.
- **NO bullet-point feature lists** in outbound.
- **NO wall of text.** Short paragraphs, mobile-friendly.
- **Sign-off (house standard):**
  ```
  Best,
  {{FIRST_NAME}}
  ```
  The word `Best,` then a newline then the rep's first name. Never `— Name` / `- Name` / `Cheers,`.

### The 4-paragraph email standard (cold / re-engagement)
Every cold email body is four short paragraphs separated by blank lines, never one block:
```
Hi {First},

[P1 opener] One diagnostic QUESTION grounded in a VERIFIED fact about their product/company.

[P2 context] One sentence on why that compounds for companies like theirs.

[P3 proof] One named customer + hard metric: "{Customer} used Testsigma to {result}, after they stopped {pain}." Name Testsigma once, here only.

[P4 CTA] Outbound: one clear, low-friction meeting ask ("what day works"). Inbound: an engagement question (never a meeting ask).

Best,
{{FIRST_NAME}}
```
A draft fails if any is false: 4 distinct paragraphs · 75-99 words · one clean proof line · opener is a question on a verified fact · correct CTA for the channel · no feature/AI headline · no resume recap · correct sign-off.

### Openers — what NOT to do
- NO "reaching out" / "wanted to connect" / "I saw" / "I noticed" (strongest negative signal).
- NO role-at-company as the primary opener ("Seeing that you're the [Title] at [Company]").
- NO resume recaps — never reference their profile, tenure, or career history.
- NO "based on your profile."

### Content
- **Ask, never assert.** Open with a diagnostic question grounded in a verified fact about their product/company — never a claim about their experience, feelings, or "what they went through."
- NO feature-led framing (leading with AI / self-healing / any marquee feature loses).
- NO generic assertions; NO feature dumping; NO credential dumping.
- One named proof point with a hard number, framed as what the *customer* achieved.

### CTAs
- **Outbound cold email:** one clear meeting ask, low-friction ("what day works next week for a quick look?"). This is the house default for outbound and the top performer for TAM outbound.
- **Inbound:** never a meeting ask — an engagement question that invites them to share their situation. The person already came to you.
- NO permission-based CTAs ("would it be unreasonable," "happy to share if helpful").
- NO easy-out lines ("no worries," "if not, all good").
- NO self-serving framing ("I want to show you").
- One CTA per message. Never two asks.

### Length & timing
- Cold email body: 75-99 words (target ~85). Follow-ups shorter (40-70).
- Best send window: afternoon; avoid evening sends.

### Sender
- All outreach sends from the rep's `{{SENDER_EMAIL}}` (their `.ai` address). The `.com` address is reserved for a rare, direct, fully-customized reply to a warm/inbound prospect (e.g. someone who asked for a demo).

---

## OPTIONAL — per-rep calibration (onboarding may lightly fill; house voice still wins)
These fields let a rep add a light personal fingerprint without breaking the house voice. Leave any field blank to inherit the house default. Nothing here may override a structural hard rule above.

- Rep identity: `{{FULL_NAME}}`, BDR at Testsigma. LinkedIn: `{{LINKEDIN_PROFILE_URL}}`.
- One-line self-description of your tone: `{{e.g. "warm, low-pressure, specific, peer-to-peer" — inherits the house voice if blank}}`
- Sentence habits: `{{e.g. simple words, contractions fine, no exclamation marks in openers}}`
- Words you'd personally never use: `{{optional banned buzzwords, on top of the house bans}}`
- Signature first name as it should render: `{{FIRST_NAME}}`

## Proof-point usage rules
- Always use specific numbers, never vague language.
- Match the proof story to the prospect's vertical and pain (the three stories above map to self-healing / velocity / coverage).
- Never use the same proof point twice for the same prospect across a sequence.
- Frame proof as what the CUSTOMER achieved, not what Testsigma does.

## Quality checkpoints (before any message leaves the system)
1. Zero hard-rule violations (em dashes, sign-off, one CTA, word count). 2. MQS ≥ 9/12 (see `qa-rules.md`). 3. Within word count. 4. Opener is a question on a verified fact. 5. No structural duplicates in the batch. 6. Every personalization claim has a research source. 7. Angle differs from previous touches for the same prospect.
