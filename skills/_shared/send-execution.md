# Send Execution + Tracking — how the skill actually sends and keeps everything in sync

This is the last mile: turning an approved, formatted draft into a real sent message, then making sure the rep's records, the send tool, and the CRM all agree afterward. Runs after the pre-send flight check (`preflight-postflight.md`) and only after the rep's explicit APPROVE SEND. Tool names come from `config.json` `tech_stack`.

## Storage & presentation rule (always)
Every email is STORED and PRESENTED in its final send format: four short paragraphs separated by blank lines, then the sign-off `{{SIGN_OFF_LINE_1}}` then `{{SIGN_OFF_LINE_2}}` (house default: `Best,` on its own line, then `{{FIRST_NAME}}`), ready to copy-paste into the composer as-is. Never store an email body as one run-on block. A connection request is stored as one short block (no line breaks) — that IS its final format.

## Send steps (email)
1. **Open the contact in the sending tool** (create/verify the contact first; verified email only).
2. **Set the sender address** to the one this motion requires (`config.tech_stack.sender_rules_by_sequence`). The default is the rep's `.ai` address (`{{SENDER_EMAIL}}`); the `.com` address is only for a rare, direct, fully-customized reply to a warm/inbound prospect (e.g. someone who asked for a demo). Many tools default to the wrong address — set it explicitly every time and confirm it shows `{{SENDER_EMAIL}}` before sending.
3. **Set / enroll the sequence** if the motion uses one; otherwise send as a standalone 1:1.
4. **Inject the subject** — the exact approved subject line, no em dash.
5. **Inject the body** — the exact approved 4-paragraph text. Preserve the blank-line paragraph breaks (inject `\n\n` between paragraphs). This is the #1 place formatting silently collapses — verify the breaks are present in the composer, not just the characters.
6. **Pre-send readback** — read the composer back and confirm, character-for-character: sender address (`{{SENDER_EMAIL}}`), recipient, subject, and body including the paragraph breaks. No placeholder text anywhere.
7. **Send**, and confirm the tool reports success (the send/thread state closes cleanly).

## Send steps (connection request)
Inject the exact approved single-block message (char-for-character readback vs the tracker), confirm no existing "Pending" state, send. Never rewrite at send time. On public LinkedIn profiles, use the Sales Navigator real-mouse flow with char-for-char readback — JS-only injected sends on public profiles are banned.

## Tracking sync (do ALL of these per send, so nothing drifts out of alignment)
The send is not "done" until every record agrees:
1. **MASTER_SENT_LIST.csv** — append one row: `name,batch,send_date,channel,credits,file,norm`. The row is the source of truth; if it's missing, the send didn't happen as far as the system is concerned.
2. **Sending tool** — the contact shows the sent activity / correct sequence step / task marked complete. No orphaned open task for a message already sent.
3. **CRM** — the account/contact reflects the touch (activity logged, stage/owner correct), so the rep and the CRM don't disagree about who was contacted.
4. **Local trackers** — the batch tracker, `memory/pipeline-state.md`, and (if warm) `memory/warm-leads.md` updated.
5. **Analytics DB** — the send is captured for reply-rate/performance reporting.

If any of these can't be updated, STOP the batch and surface it — a half-logged send is how dedup and reporting drift.

## After the batch
- Run the post-send maintenance check (`preflight-postflight.md`): confirm each message landed as written, sweep for bounces/opt-outs (→ DNC), log any incident.
- Reconcile: the count of MASTER rows added == the count of sends fired == the count of tool activities. Three numbers, one truth.
