#!/usr/bin/env bash
# =============================================================================
#  PII / leak guardrail for the Testsigma BDR starter kit.
#
#  This kit is a PUBLIC template. It must ship EMPTY of people-data: the live
#  files (config.json, MASTER_SENT_LIST.csv, data/*.csv, memory/*.md, *.db,
#  batches/active/*) are gitignored, and only the *.example.* header files are
#  committed. This script is the automated backstop that fails CI (and local
#  runs) if a real secret or a live-data file ever sneaks into git.
#
#  It scans only GIT-TRACKED files (so a rep's own gitignored config.json is
#  never falsely flagged) and skips .git and the two scanner scripts themselves
#  (which necessarily contain the very regexes they hunt for).
#
#  Exit 0 = clean.   Exit 1 = at least one finding (report printed, grouped).
# =============================================================================
set -euo pipefail

# --- Locate repo root so the script works from any working directory ---------
if ! REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null)"; then
  echo "ERROR: not inside a git working tree (git rev-parse failed)." >&2
  exit 2
fi
cd "$REPO_ROOT"

# The scanner's own files must never scan themselves.
SELF_SH="scripts/pii-scan.sh"
SELF_PS1="scripts/pii-scan.ps1"

# --- Enumerate tracked files (NUL-delimited -> array) ------------------------
# git ls-files lists ONLY tracked files and never lists .git, so "except .git"
# and "git-tracked only" are both satisfied for free.
TRACKED=()
while IFS= read -r -d '' f; do
  TRACKED+=("$f")
done < <(git ls-files -z)

TOTAL=${#TRACKED[@]}

# Content-scan set = tracked files minus the two scanner scripts.
SCAN_FILES=()
for f in "${TRACKED[@]}"; do
  case "$f" in
    "$SELF_SH"|"$SELF_PS1") continue ;;
  esac
  SCAN_FILES+=("$f")
done
SCANNED=${#SCAN_FILES[@]}

# --- Report accumulator ------------------------------------------------------
fail=0
report=""
add() {                       # add <heading> <matches-block>
  report+=$'\n'"  ── ${1}"$'\n'
  # indent each match line for readability
  report+="$(printf '%s\n' "$2" | sed 's/^/     /')"$'\n'
  fail=1
}

# Content grep helper. Adds a group only when there are hits.
#   scan <heading> <ERE> [extra grep flags]
scan() {
  local heading="$1" pat="$2" extra="${3:-}"
  [ "$SCANNED" -eq 0 ] && return 0     # never let grep read stdin
  local hits
  # -n line numbers, -I skip binary, -E extended regex. || true: no match is fine.
  hits=$(grep -EnI ${extra} -- "$pat" "${SCAN_FILES[@]}" 2>/dev/null || true)
  [ -n "$hits" ] && add "$heading" "$hits"
  return 0
}

# =============================================================================
#  (a) A tracked file whose PATH is one of the gitignored live-data names.
#      The *.example.* variants have different names, so they pass untouched.
# =============================================================================
LIVE_DATA_PATHS='^(config\.json|MASTER_SENT_LIST\.csv|data/target-accounts\.csv|data/suppression-list\.csv|memory/do-not-contact\.md|memory/warm-leads\.md|memory/call-log\.md|memory/pipeline-state\.md|memory/contact-lifecycle\.md|memory/daily-log\.md|memory/incidents\.md|analytics/.*\.db)$|(^|/)\.env$'
path_hits=$(printf '%s\n' "${TRACKED[@]}" | grep -E "$LIVE_DATA_PATHS" || true)
[ -n "$path_hits" ] && add "(a) Live-data file committed (must be gitignored)" "$path_hits"

# =============================================================================
#  (b) 24-hex Apollo / record id.  Bounded to EXACTLY 24 hex chars (flanked by
#      non-hex or line edge) so real 24-char Apollo ids trip it, but a 40-char
#      git SHA in a changelog does not.
# =============================================================================
scan "(b) 24-hex token (Apollo/record id)" '(^|[^0-9a-f])[0-9a-f]{24}([^0-9a-f]|$)'

# =============================================================================
#  (c) Personal email (@gmail.com / @yahoo.com).  Case-insensitive.
#      Requires a local-part before the '@' so a REAL address (rob@gmail.com)
#      trips it, but a bare domain reference in prose/docs (e.g. the README
#      describing "we block @gmail.com") does not. testsigma.ai never matches.
# =============================================================================
scan "(c) Personal email address" '[A-Za-z0-9._%+-]+@(gmail|yahoo)\.com' '-i'

# =============================================================================
#  (d) US phone number  NNN-NNN-NNNN or NNN.NNN.NNNN
# =============================================================================
scan "(d) Phone number" '\b[0-9]{3}[-.][0-9]{3}[-.][0-9]{4}\b'

# =============================================================================
#  (e) Real LinkedIn slug.  linkedin.com/in/<slug> template is allowed because
#      the char after /in/ is '<', which is not in [a-z0-9-].
# =============================================================================
scan "(e) Real LinkedIn slug" 'linkedin\.com/in/[a-z0-9-]{3,}'

# =============================================================================
#  (f) OLD generic template placeholders (a regression to the pre-Testsigma
#      skeleton).  Per-rep tokens like {{FIRST_NAME}} are fine and not listed.
# =============================================================================
scan "(f) Obsolete generic placeholder" '\{\{(COMPANY_NAME|PRODUCT_NAME|VALUE_PROP_1|CUSTOMER_1|PRIMARY_TITLE_1|VERTICAL_1|SENDER_ADDRESS|CRM)\}\}'

# =============================================================================
#  Verdict
# =============================================================================
EXCLUDED=$((TOTAL - SCANNED))
echo "PII/leak scan: ${TOTAL} tracked files (${SCANNED} content-scanned, ${EXCLUDED} scanner script(s) excluded)."

if [ "$fail" -ne 0 ]; then
  echo ""
  echo "FAIL: potential PII / leak(s) found:"
  printf '%s\n' "$report"
  echo "Remove or gitignore the above before committing. See .gitignore + README."
  exit 1
fi

echo "PASS: no PII, secrets, live-data files, or obsolete placeholders found."
exit 0
