# Gold Standards — illustrative examples of the house voice

> These are **illustrative, annotated examples** that show what the Testsigma house voice sounds like when it lands. They are NOT fill-in templates and NOT copies of any real sent message. Every prospect and company below is **fictional** — invented to demonstrate the voice. The real words in a real draft come from `voice-profile.md` + per-contact research. Proof metrics use only Testsigma's external-safe stories (Hansard / Medibuddy / CRED) and the public reference customers.

---

## Example 1 — Cold email T1 (outbound)
*Recipient: "Jordan Lee," QA Director at a fictional fintech called **Acme Pay** (all fictional).*

```
Subject: Acme Pay's new instant-payouts flow

Hi Jordan,

Now that Acme Pay has shipped instant payouts, how are you keeping the
regression suite honest across all the new edge cases without the run time
ballooning?

For fintech teams, every new money-movement path multiplies the states you
have to re-test, and that is usually where manual coverage quietly falls
behind.

Hansard used Testsigma to cut a regression cycle from 8 weeks to 5, after
they stopped hand-patching brittle scripts every release.

What day next week works for a quick look at how that could map to Acme Pay?

Best,
{{FIRST_NAME}}
```

**Why it works**
- **Opener is a question on a verified fact** (the instant-payouts launch), not a claim about Jordan's feelings or career. Ask, don't assert.
- **Subject line has no em dash** and names their world, not our feature.
- **Context paragraph** explains why the pain compounds *for fintech specifically* without asserting they have it.
- **One clean proof line**, framed as what the customer achieved, Testsigma named exactly once.
- **One outbound CTA** — a low-friction "what day works" ask. ~80 words, four short paragraphs, correct sign-off.

---

## Example 2 — LinkedIn connection request
*Recipient: "Priya Menon," VP Engineering at a fictional e-commerce company called **Nimbus Retail** (all fictional).*

```
Hi Priya, I work with engineering leaders on test automation, mostly around
keeping coverage stable while teams ship fast. Nimbus scaling checkout to new
regions is exactly the kind of surface-area jump that stresses a regression
suite. Would be glad to connect and trade notes.
```

**Why it works**
- **Under ~300 characters, no question mark, no em dash, no product name-drop** — the connect note is an introduction, not a pitch.
- **One verified signal line** (the multi-region checkout expansion) that traces to real evidence, judged on Priya's live headline as a valid persona (VP Engineering).
- **Low-pressure close** ("glad to connect and trade notes"), no meeting ask, no easy-out.
- Peer-to-peer framing: "I work with engineering leaders," not "I'd love to show you our platform."

---

## Example 3 — Follow-up (T2), new angle
*Same fictional recipient as Example 1 (Jordan Lee, Acme Pay). Sent as a reply on the original thread.*

```
Hi Jordan,

Circling back quick. Beyond keeping payouts stable, the other thing fintech
QA leaders raise with me is how long it takes to build coverage for a brand
new flow in the first place.

Medibuddy got to 2,500 tests and cut maintenance about half by writing them
in plain English instead of hand-coding each one.

Would it be worth 15 minutes to see if that changes the math for your team?

Best,
{{FIRST_NAME}}
```

**Why it works**
- **New angle and a different proof** (velocity / Medibuddy) than the T1 (self-healing / Hansard) — never rehash.
- **Shorter** (~60 words), references the prior touch lightly, one CTA.
- No em dashes, correct sign-off, still ask-shaped.

---

## Structural calibration (shape references, not copy)

### Break-up — shortest (30-50 words)
- Acknowledge the silence without guilt-tripping.
- Never pitch in the break-up.
- Leave the door open: "If the timing isn't right, totally get it, just closing the loop so I'm not clogging your inbox."

### Cold-call snippet (3 lines max)
- Line 1: "Hey {Name}, this is {{FIRST_NAME}} from Testsigma, {personalized hook}."
- Line 2: "{Specific problem tied to their context}."
- Line 3: "We helped {proof point}. Worth 60 seconds to see if it's relevant?"
- Use a DIFFERENT proof and pain hypothesis than the email/InMail touches.

## What a great message is NOT
> "Hey {Name}, I saw you worked at {Company} for {X} years leading {team}. That must mean {assumption}. {Client} saved {number}. Would 15 minutes make sense?"

That formula is dead. Every prospect has seen it a hundred times. Ask about their world instead of reciting theirs back to them.
