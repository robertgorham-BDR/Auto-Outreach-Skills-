#!/usr/bin/env bash
# =====================================================================
# validate-setup.sh - post-onboarding preflight for the Testsigma BDR
# starter kit. A rep runs this AFTER onboarding, BEFORE the first batch.
#
# Prints a [PASS]/[FAIL] checklist for:
#   1. config.json exists
#   2. config.json is gitignored
#   3. CLAUDE.md exists (saved from the template)
#   4. no unfilled {{placeholders}} remain in config.json / CLAUDE.md
#   5. the configured sender address ends in @testsigma.ai
#   6. MASTER_SENT_LIST.csv exists locally AND is gitignored
#   7. data/target-accounts.csv exists
#
# Each FAIL prints a one-line fix hint. Exits 1 if any check FAILs.
# Run from anywhere: it locates the repo root relative to itself.
# =====================================================================

set -u

# --- locate repo root (the parent of this script's directory) ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$ROOT" || { echo "Cannot cd to repo root: $ROOT"; exit 1; }

PASSES=0
FAILS=0

# --- color only when writing to a terminal ---
if [ -t 1 ]; then
  G='\033[32m'; R='\033[31m'; Y='\033[33m'; B='\033[1m'; N='\033[0m'
else
  G=''; R=''; Y=''; B=''; N=''
fi

pass() {
  printf '  [%bPASS%b] %s\n' "$G" "$N" "$1"
  PASSES=$((PASSES + 1))
}
fail() {
  printf '  [%bFAIL%b] %s\n' "$R" "$N" "$1"
  printf '         %bfix:%b %s\n' "$Y" "$N" "$2"
  FAILS=$((FAILS + 1))
}

# --- git helpers ---
in_git_repo() { git rev-parse --is-inside-work-tree >/dev/null 2>&1; }
is_ignored()  { git check-ignore -q -- "$1" 2>/dev/null; }

printf '%bTestsigma BDR starter kit - setup validation%b\n' "$B" "$N"
printf 'repo: %s\n\n' "$ROOT"

# --- 1. config.json exists ---
if [ -f config.json ]; then
  pass "config.json exists"
else
  fail "config.json exists" \
    "Copy config.example.json to config.json and run onboarding to fill it in."
fi

# --- 2. config.json is gitignored ---
if in_git_repo; then
  if is_ignored config.json; then
    pass "config.json is gitignored"
  else
    fail "config.json is gitignored" \
      "Add 'config.json' to .gitignore so your filled-in config is never committed."
  fi
else
  fail "config.json is gitignored" \
    "Not a git repo here - run this from inside the cloned starter-kit repo."
fi

# --- 3. CLAUDE.md exists (saved from CLAUDE.template.md) ---
if [ -f CLAUDE.md ]; then
  pass "CLAUDE.md exists"
else
  fail "CLAUDE.md exists" \
    "Save your filled CLAUDE.md (onboarding generates it from CLAUDE.template.md)."
fi

# --- 4. no literal {{ remains in config.json or CLAUDE.md ---
LEFT=""
for f in config.json CLAUDE.md; do
  if [ -f "$f" ] && grep -Fq '{{' "$f"; then
    LEFT="$LEFT $f"
  fi
done
if [ -n "$LEFT" ]; then
  fail "no unfilled {{placeholders}} in config.json / CLAUDE.md" \
    "Replace every {{...}} token in:${LEFT}"
else
  pass "no unfilled {{placeholders}} in config.json / CLAUDE.md"
fi

# --- 5. configured sender address ends in @testsigma.ai ---
# Read tech_stack.sender_addresses[0] specifically (NOT a whole-file grep -
# the config carries an inline .ai example in sender_domain_rule.default).
SENDER=""
if [ -f config.json ]; then
  if command -v jq >/dev/null 2>&1; then
    SENDER="$(jq -r '.tech_stack.sender_addresses[0] // empty' config.json 2>/dev/null)"
  fi
  if [ -z "$SENDER" ]; then
    SENDER="$(grep -o '"sender_addresses"[^]]*]' config.json 2>/dev/null \
      | grep -oE '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+' | head -n1)"
  fi
fi
case "$SENDER" in
  *@testsigma.ai)
    pass "sender address ends in @testsigma.ai ($SENDER)" ;;
  "")
    fail "sender address ends in @testsigma.ai" \
      "Set tech_stack.sender_addresses[0] to your firstname.lastname@testsigma.ai address." ;;
  *)
    fail "sender address ends in @testsigma.ai" \
      "Found '$SENDER' - outreach must send from your .ai address, not .com/.in/other." ;;
esac

# --- 6. MASTER_SENT_LIST.csv exists locally AND is gitignored ---
M_EXISTS=0; M_IGN=0
[ -f MASTER_SENT_LIST.csv ] && M_EXISTS=1
if in_git_repo && is_ignored MASTER_SENT_LIST.csv; then
  M_IGN=1
fi
if [ "$M_EXISTS" -eq 1 ] && [ "$M_IGN" -eq 1 ]; then
  pass "MASTER_SENT_LIST.csv exists locally and is gitignored"
else
  HINT=""
  [ "$M_EXISTS" -eq 0 ] && HINT="Create it: cp MASTER_SENT_LIST.example.csv MASTER_SENT_LIST.csv."
  [ "$M_IGN" -eq 0 ]    && HINT="$HINT Ensure 'MASTER_SENT_LIST.csv' is in .gitignore."
  fail "MASTER_SENT_LIST.csv exists locally and is gitignored" "${HINT# }"
fi

# --- 7. data/target-accounts.csv exists ---
if [ -f data/target-accounts.csv ]; then
  pass "data/target-accounts.csv exists"
else
  fail "data/target-accounts.csv exists" \
    "Add your TAM list at data/target-accounts.csv (gitignored; your accounts never get committed)."
fi

# --- summary ---
printf '\n%bResult: %d passed, %d failed%b\n' "$B" "$PASSES" "$FAILS" "$N"
if [ "$FAILS" -gt 0 ]; then
  printf '%bSetup incomplete - fix the FAIL items above before your first batch.%b\n' "$R" "$N"
  exit 1
fi
printf '%bAll checks passed - you are cleared to run your first batch.%b\n' "$G" "$N"
exit 0
