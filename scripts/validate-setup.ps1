# =====================================================================
# validate-setup.ps1 - post-onboarding preflight for the Testsigma BDR
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
# Compatible with Windows PowerShell 5.1 and PowerShell 7+.
# =====================================================================

# --- locate repo root (the parent of this script's directory) ---
$ScriptPath = $PSCommandPath
if (-not $ScriptPath) { $ScriptPath = $MyInvocation.MyCommand.Path }
$ScriptDir = Split-Path -Parent $ScriptPath
$Root = Split-Path -Parent $ScriptDir
Set-Location -LiteralPath $Root

$script:Passes = 0
$script:Fails  = 0

function Write-Pass([string]$label) {
  Write-Host "  [" -NoNewline
  Write-Host "PASS" -ForegroundColor Green -NoNewline
  Write-Host "] $label"
  $script:Passes++
}
function Write-Fail([string]$label, [string]$fix) {
  Write-Host "  [" -NoNewline
  Write-Host "FAIL" -ForegroundColor Red -NoNewline
  Write-Host "] $label"
  Write-Host "         fix: $fix" -ForegroundColor Yellow
  $script:Fails++
}

# --- git helpers ---
function Test-GitRepo {
  try { & git rev-parse --is-inside-work-tree 2>$null | Out-Null; return ($LASTEXITCODE -eq 0) }
  catch { return $false }
}
function Test-GitIgnored([string]$path) {
  try { & git check-ignore -q -- $path 2>$null; return ($LASTEXITCODE -eq 0) }
  catch { return $false }
}

$IsRepo = Test-GitRepo

Write-Host "Testsigma BDR starter kit - setup validation" -ForegroundColor Cyan
Write-Host "repo: $Root"
Write-Host ""

# --- 1. config.json exists ---
if (Test-Path -LiteralPath 'config.json') {
  Write-Pass 'config.json exists'
} else {
  Write-Fail 'config.json exists' 'Copy config.example.json to config.json and run onboarding to fill it in.'
}

# --- 2. config.json is gitignored ---
if ($IsRepo) {
  if (Test-GitIgnored 'config.json') {
    Write-Pass 'config.json is gitignored'
  } else {
    Write-Fail 'config.json is gitignored' "Add 'config.json' to .gitignore so your filled-in config is never committed."
  }
} else {
  Write-Fail 'config.json is gitignored' 'Not a git repo here - run this from inside the cloned starter-kit repo.'
}

# --- 3. CLAUDE.md exists (saved from CLAUDE.template.md) ---
if (Test-Path -LiteralPath 'CLAUDE.md') {
  Write-Pass 'CLAUDE.md exists'
} else {
  Write-Fail 'CLAUDE.md exists' 'Save your filled CLAUDE.md (onboarding generates it from CLAUDE.template.md).'
}

# --- 4. no literal {{ remains in config.json or CLAUDE.md ---
$left = @()
foreach ($f in @('config.json','CLAUDE.md')) {
  if (Test-Path -LiteralPath $f) {
    $content = Get-Content -LiteralPath $f -Raw
    if ($content -match '\{\{') { $left += $f }
  }
}
if ($left.Count -gt 0) {
  Write-Fail 'no unfilled {{placeholders}} in config.json / CLAUDE.md' ("Replace every {{...}} token in: " + ($left -join ', '))
} else {
  Write-Pass 'no unfilled {{placeholders}} in config.json / CLAUDE.md'
}

# --- 5. configured sender address ends in @testsigma.ai ---
# Read tech_stack.sender_addresses[0] specifically (NOT a whole-file match -
# the config carries an inline .ai example in sender_domain_rule.default).
$sender = ''
if (Test-Path -LiteralPath 'config.json') {
  try {
    $cfg = Get-Content -LiteralPath 'config.json' -Raw | ConvertFrom-Json
    $sa = $cfg.tech_stack.sender_addresses
    if ($sa) { $sender = [string]@($sa)[0] }
  } catch { $sender = '' }
}
if ($sender -match '@testsigma\.ai$') {
  Write-Pass "sender address ends in @testsigma.ai ($sender)"
} elseif (-not $sender) {
  Write-Fail 'sender address ends in @testsigma.ai' 'Set tech_stack.sender_addresses[0] to your firstname.lastname@testsigma.ai address.'
} else {
  Write-Fail 'sender address ends in @testsigma.ai' "Found '$sender' - outreach must send from your .ai address, not .com/.in/other."
}

# --- 6. MASTER_SENT_LIST.csv exists locally AND is gitignored ---
$mExists = Test-Path -LiteralPath 'MASTER_SENT_LIST.csv'
$mIgn = $false
if ($IsRepo) { $mIgn = Test-GitIgnored 'MASTER_SENT_LIST.csv' }
if ($mExists -and $mIgn) {
  Write-Pass 'MASTER_SENT_LIST.csv exists locally and is gitignored'
} else {
  $hint = ''
  if (-not $mExists) { $hint = 'Create it: Copy-Item MASTER_SENT_LIST.example.csv MASTER_SENT_LIST.csv. ' }
  if (-not $mIgn)    { $hint = $hint + "Ensure 'MASTER_SENT_LIST.csv' is in .gitignore." }
  Write-Fail 'MASTER_SENT_LIST.csv exists locally and is gitignored' $hint.Trim()
}

# --- 7. data/target-accounts.csv exists ---
if (Test-Path -LiteralPath (Join-Path 'data' 'target-accounts.csv')) {
  Write-Pass 'data/target-accounts.csv exists'
} else {
  Write-Fail 'data/target-accounts.csv exists' 'Add your TAM list at data/target-accounts.csv (gitignored; your accounts never get committed).'
}

# --- summary ---
Write-Host ""
Write-Host ("Result: {0} passed, {1} failed" -f $script:Passes, $script:Fails) -ForegroundColor Cyan
if ($script:Fails -gt 0) {
  Write-Host 'Setup incomplete - fix the FAIL items above before your first batch.' -ForegroundColor Red
  exit 1
}
Write-Host 'All checks passed - you are cleared to run your first batch.' -ForegroundColor Green
exit 0
