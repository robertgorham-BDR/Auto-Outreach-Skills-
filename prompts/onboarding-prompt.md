# Onboarding prompt — paste this into your agent, once

> You're a Testsigma BDR who just cloned this kit. Everything about Testsigma (product, ICP, proof points, house voice, outreach process) is already baked in. Onboarding only binds the kit to YOU. Copy the block below and paste it to your AI agent (Claude Code or Cowork) **with this repo folder open**.

```
I'm a new Testsigma BDR. I just cloned my BDR Starter Kit into this folder. Set it up for me.

Run the onboarding skill at skills/onboarding/SKILL.md. Testsigma's company, product, ICP,
personas, proof points, house voice, and outreach gauntlet are ALREADY baked into this kit —
do NOT interview me about any of that or re-ask it. Only ask me what's specific to me, and
wait for my answers.

First (Step 0), get my machine + stack set up:
- Confirm this folder is my work folder and my assigned Testsigma WORK GitHub repo
  (check git remote points at the assigned work repo, never a personal one).
- Inventory my tools: work Chrome profile, Apollo (web + MCP), work Gmail, Calendar,
  and Salesforce/G2 via my Work tab group. Tell me what to connect.
- Survey my existing Apollo sequences and read each one's step structure (manual-task
  email step vs automated-template step vs LinkedIn step) so routing is correct.

Then interview me ONLY for what's mine:
- Me: full name, work email, timezone, LinkedIn URL.
- My sender email: my Testsigma .ai address (firstname.lastname@testsigma.ai).
- My Apollo: login email, my .ai email-account ID, my .com email-account ID, my sequence IDs.
- My assigned accounts / TAM slice (which accounts I'm allowed to prospect).
- My quota: monthly SAL target and daily targets (emails / LinkedIn / calls).
- Optional voice tune: keep the Testsigma house voice by default; if I want, I'll paste a
  line or two I'd naturally open with and you match the rhythm. Don't change the structural
  rules (no em dashes, one CTA, ask-don't-assert, 75-99 word Touch 1, "Best," + my first name).

Then:
1. Write my answers into config.json (copy from config.example.json first). The company,
   ICP, proof, and voice sections are Testsigma house defaults — fill them from the baked-in
   canon, don't ask me.
2. Set my identity + any tone deltas in memory/context/voice-profile.md, keeping every
   structural rule as written.
3. Replace every {{placeholder}} across the kit from config.json, and save the .template.md
   files as their real names (CLAUDE.template.md -> CLAUDE.md, AGENTS.template.md -> AGENTS.md).
4. Grep the repo for "{{" and confirm zero results.
5. Confirm config.json is gitignored, and that the only name, email, or Apollo ID anywhere
   in the repo is mine — no other rep's data is present.
6. Walk me through connecting my tools.

Do NOT import anyone else's contacts, accounts, sent lists, or Apollo/sequence IDs. This kit
ships empty of rep data on purpose — I bring my own. When you're done, tell me how to run my
first batch.
```

## After onboarding
- Add your assigned accounts to `data/target-accounts.csv`.
- Paste `prompts/build-batch-prompt.md` to run your first batch.
- Each morning, paste `prompts/run-my-day-prompt.md`.
