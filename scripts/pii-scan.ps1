<#
  =============================================================================
   PII / leak guardrail for the Testsigma BDR starter kit  (PowerShell mirror).

   Windows-local equivalent of scripts/pii-scan.sh. Same checks (a)-(f), same
   exit codes:  0 = clean,  1 = finding(s),  2 = not a git repo.

   Scans only GIT-TRACKED files (so a rep's own gitignored config.json is never
   falsely flagged) and skips .git and the two scanner scripts themselves.

   Run:  powershell -ExecutionPolicy Bypass -File scripts\pii-scan.ps1
  =============================================================================
#>
$ErrorActionPreference = 'Stop'

# --- Locate repo root --------------------------------------------------------
try   { $RepoRoot = (git rev-parse --show-toplevel 2>$null) }
catch { $RepoRoot = $null }
if ([string]::IsNullOrWhiteSpace($RepoRoot)) {
    Write-Output "ERROR: not inside a git working tree (git rev-parse failed)."
    exit 2
}
Set-Location $RepoRoot

$SelfSh  = 'scripts/pii-scan.sh'
$SelfPs1 = 'scripts/pii-scan.ps1'

# --- Enumerate tracked files -------------------------------------------------
$Tracked = @(git ls-files | Where-Object { $_ -ne '' })
$Total   = $Tracked.Count

# Content-scan set = tracked files minus the two scanner scripts.
$ScanFiles = @($Tracked | Where-Object { $_ -ne $SelfSh -and $_ -ne $SelfPs1 })
$Scanned   = $ScanFiles.Count

$Fail   = $false
$Report = New-Object System.Collections.Generic.List[string]

function Add-Finding {
    param([string]$Heading, [string[]]$Matches)
    $script:Fail = $true
    $script:Report.Add("")
    $script:Report.Add("  -- $Heading")
    foreach ($m in $Matches) { $script:Report.Add("     $m") }
}

# Content-scan helper. Matches file:line:text like grep -n.
#   Invoke-Scan <heading> <regex> [-CaseSensitive]
function Invoke-Scan {
    param(
        [string]$Heading,
        [string]$Pattern,
        [switch]$CaseSensitive
    )
    if ($Scanned -eq 0) { return }
    $hits = New-Object System.Collections.Generic.List[string]
    $opts = if ($CaseSensitive) { [Text.RegularExpressions.RegexOptions]::None }
            else { [Text.RegularExpressions.RegexOptions]::IgnoreCase }
    $re = [regex]::new($Pattern, $opts)
    foreach ($file in $ScanFiles) {
        if (-not (Test-Path -LiteralPath $file)) { continue }
        # Skip binary-ish files (NUL byte in first block); mirrors grep -I.
        try {
            $bytes = [System.IO.File]::ReadAllBytes($file)
        } catch { continue }
        if ($bytes.Length -gt 0) {
            $probe = [Math]::Min($bytes.Length, 8000)
            $isBinary = $false
            for ($i = 0; $i -lt $probe; $i++) { if ($bytes[$i] -eq 0) { $isBinary = $true; break } }
            if ($isBinary) { continue }
        }
        $lineNo = 0
        foreach ($line in [System.IO.File]::ReadAllLines($file)) {
            $lineNo++
            if ($re.IsMatch($line)) {
                $hits.Add("$($file):$($lineNo):$($line.Trim())")
            }
        }
    }
    if ($hits.Count -gt 0) { Add-Finding $Heading $hits.ToArray() }
}

# =============================================================================
#  (a) Tracked file whose PATH is a gitignored live-data name.
# =============================================================================
$LiveDataPaths = '^(config\.json|MASTER_SENT_LIST\.csv|data/target-accounts\.csv|data/suppression-list\.csv|memory/do-not-contact\.md|memory/warm-leads\.md|memory/call-log\.md|memory/pipeline-state\.md|memory/contact-lifecycle\.md|memory/daily-log\.md|memory/incidents\.md|analytics/.*\.db)$|(^|/)\.env$'
$pathRe   = [regex]::new($LiveDataPaths)
$pathHits = @($Tracked | Where-Object { $pathRe.IsMatch($_) })
if ($pathHits.Count -gt 0) { Add-Finding "(a) Live-data file committed (must be gitignored)" $pathHits }

# =============================================================================
#  (b) 24-hex Apollo / record id (exactly 24, flanked by non-hex/line edge).
# =============================================================================
Invoke-Scan "(b) 24-hex token (Apollo/record id)" '(^|[^0-9a-f])[0-9a-f]{24}([^0-9a-f]|$)' -CaseSensitive

# =============================================================================
#  (c) Personal email (@gmail.com / @yahoo.com), case-insensitive.
#      Requires a local-part before '@' so a REAL address trips it but a bare
#      domain reference in prose/docs does not. testsigma.ai never matches.
# =============================================================================
Invoke-Scan "(c) Personal email address" '[A-Za-z0-9._%+-]+@(gmail|yahoo)\.com'

# =============================================================================
#  (d) US phone number  NNN-NNN-NNNN or NNN.NNN.NNNN
# =============================================================================
Invoke-Scan "(d) Phone number" '\b[0-9]{3}[-.][0-9]{3}[-.][0-9]{4}\b'

# =============================================================================
#  (e) Real LinkedIn slug (linkedin.com/in/<slug> template is allowed).
# =============================================================================
Invoke-Scan "(e) Real LinkedIn slug" 'linkedin\.com/in/[a-z0-9-]{3,}' -CaseSensitive

# =============================================================================
#  (f) OLD generic template placeholders.
# =============================================================================
Invoke-Scan "(f) Obsolete generic placeholder" '\{\{(COMPANY_NAME|PRODUCT_NAME|VALUE_PROP_1|CUSTOMER_1|PRIMARY_TITLE_1|VERTICAL_1|SENDER_ADDRESS|CRM)\}\}' -CaseSensitive

# =============================================================================
#  Verdict
# =============================================================================
$Excluded = $Total - $Scanned
Write-Output ("PII/leak scan: {0} tracked files ({1} content-scanned, {2} scanner script(s) excluded)." -f $Total, $Scanned, $Excluded)

if ($Fail) {
    Write-Output ""
    Write-Output "FAIL: potential PII / leak(s) found:"
    foreach ($line in $Report) { Write-Output $line }
    Write-Output "Remove or gitignore the above before committing. See .gitignore + README."
    exit 1
}

Write-Output "PASS: no PII, secrets, live-data files, or obsolete placeholders found."
exit 0
