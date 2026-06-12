# First Windows Release + Release Script Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create `tool/release.ps1` (the one-command Windows release ritual) plus `docs/RELEASING.md`, then use them to ship Enigma Signal Meter **1.1.2+5001** as the first public Windows release.

**Architecture:** A single PowerShell 7 script with testable helper functions (version parsing, manifest read/append/write) and a linear main flow guarded by preflight checks. The canonical update manifest `tool/app-archive.json` lives in git. The script stops at an upload-ready bundle in `dist\<build>\upload\`; uploading to www.krkadoni.com stays manual.

**Tech Stack:** PowerShell 7 (`Compress-Archive`, `ConvertTo-Json`), Flutter Windows toolchain, `desktop_updater` 2.0.0-dev.1 release/archive CLI.

**Spec:** `docs/superpowers/specs/2026-06-12-windows-first-release-design.md`

---

## Repo facts the engineer must know

- **This repo stores source as LF.** Create new files with LF line endings. Keep `tool/release.ps1` ASCII-only (no smart quotes, no box-drawing characters) so encoding can never bite.
- **Never `git add -A`.** Stage exact paths.
- `pubspec.lock` and `.metadata` are gitignored — never try to stage them.
- `dist/` is gitignored. `tool/` does not exist yet; `tool/app-archive.json` and `tool/release.ps1` WILL be tracked.
- Current pubspec version is `1.1.2+5001` (line 16 of `pubspec.yaml`). **Do not bump it** — this exact version is the first release.
- We are on branch `feature/windows-auto-update` until Task 7. The script's "must be on master" guard is EXPECTED to fail before then — that is how we test it.
- Verified plugin facts (desktop_updater 2.0.0-dev.1): `dart run desktop_updater:release windows` stages the flutter release build into `dist\<build>\enigma_signal_meter-<ver>+<build>-windows\`; `dart run desktop_updater:archive windows` copies it to `dist\<build>\<ver>+<build>-windows\` and writes Blake2b `hashes.json`. The manifest's `shortVersion` is a JSON **number** (plugin `ItemModel` declares `int`); `url` keeps its trailing `/`. A leftover E2E test output exists at `dist\5002\` and is deleted in Task 8.
- All test invocations use a **child pwsh** (`pwsh -NoProfile ...`) because the script's `Fail` helper calls `exit 1` — dot-sourcing it in your interactive session and hitting a failure would kill your shell.

---

### Task 1: Script skeleton — parameters, helpers, version parsing

**Files:**
- Create: `tool/release.ps1`

- [ ] **Step 1: Create `tool/release.ps1`**

```powershell
#Requires -Version 7
<#
.SYNOPSIS
Builds, packages and stages a Windows release of Enigma Signal Meter.

.DESCRIPTION
Automates the release ritual from
docs/superpowers/specs/2026-06-12-windows-first-release-design.md:
preflight guards -> cold release build -> desktop_updater release/archive
-> first-install zip -> manifest append (tool/app-archive.json) -> upload
bundle under dist\<build>\upload with printed upload instructions.

Run from anywhere inside the repo:
  pwsh -NoProfile -File tool\release.ps1 -Notes "Short release note"
#>
[CmdletBinding()]
param(
    # Release-note lines; each becomes one changes[] entry in the manifest.
    [string[]]$Notes = @(),
    # Marks the release mandatory (the update dialog loses "Later").
    [switch]$Mandatory,
    # Overwrite an existing dist\<build> output.
    [switch]$Force
)

$ErrorActionPreference = 'Stop'

$script:RepoRoot = Split-Path $PSScriptRoot -Parent
$script:ProductionManifestUrl = 'https://www.krkadoni.com/signalmeter/app-archive.json'
$script:BaseUrl = 'https://www.krkadoni.com/signalmeter'
$script:AppName = 'Enigma Signal Meter'
$script:AppDescription = 'Enigma Signal Meter desktop updates'
$script:ManifestPath = Join-Path $PSScriptRoot 'app-archive.json'

function Fail([string]$Message) {
    Write-Host "RELEASE ABORTED: $Message" -ForegroundColor Red
    exit 1
}

# Runs a native command and aborts on non-zero exit code. Only for native
# executables (flutter/dart/git) - cmdlets do not set $LASTEXITCODE.
function Invoke-Step([string]$Name, [scriptblock]$Command) {
    Write-Host "==> $Name" -ForegroundColor Cyan
    & $Command
    if ($LASTEXITCODE -ne 0) { Fail "step '$Name' failed with exit code $LASTEXITCODE" }
}

function Get-PubspecVersion([string]$PubspecPath) {
    if (-not (Test-Path $PubspecPath)) { Fail "$PubspecPath not found" }
    $line = Get-Content $PubspecPath |
        Where-Object { $_ -match '^version:' } |
        Select-Object -First 1
    if (-not $line) { Fail "no 'version:' line in $PubspecPath" }
    if ($line -notmatch '^version:\s*(\d+\.\d+\.\d+)\+(\d+)\s*$') {
        Fail "version line '$line' is not in <major.minor.patch>+<build> form"
    }
    [pscustomobject]@{ Display = $Matches[1]; Build = [int]$Matches[2] }
}

# --- main (everything below is skipped when dot-sourced for testing) -------
if ($MyInvocation.InvocationName -eq '.') { return }
```

Note the final guard line: Tasks 3-5 append the main flow AFTER it. When the file is dot-sourced (`. .\tool\release.ps1`) only the functions load, so they can be tested in isolation.

- [ ] **Step 2: Verify version parsing against the real pubspec**

Run from the repo root:

```powershell
pwsh -NoProfile -Command ". .\tool\release.ps1; Get-PubspecVersion 'pubspec.yaml' | Format-List"
```

Expected output (and exit code 0):

```
Display : 1.1.2
Build   : 5001
```

The indented `version: ^3.0.2` dependency line in pubspec must NOT match (the regex is anchored to line start).

- [ ] **Step 3: Verify the malformed-version guard fails**

```powershell
Set-Content tmp-pubspec.yaml 'version: 1.2.3'
pwsh -NoProfile -Command ". .\tool\release.ps1; Get-PubspecVersion 'tmp-pubspec.yaml'"
$LASTEXITCODE
Remove-Item tmp-pubspec.yaml
```

Expected: red line `RELEASE ABORTED: version line 'version: 1.2.3' is not in <major.minor.patch>+<build> form`, and `$LASTEXITCODE` prints `1`.

- [ ] **Step 4: Commit**

```powershell
git add tool/release.ps1
git commit -m "feat(release): release script skeleton with version parsing"
```

---

### Task 2: Manifest functions

**Files:**
- Modify: `tool/release.ps1` (insert BEFORE the `# --- main` guard line)

- [ ] **Step 1: Add the four manifest functions**

Insert immediately after `Get-PubspecVersion` (before the dot-source guard):

```powershell
function Read-Manifest([string]$Path) {
    if (Test-Path $Path) {
        return Get-Content $Path -Raw | ConvertFrom-Json
    }
    # First release: the canonical manifest does not exist yet.
    [pscustomobject]@{
        appName     = $script:AppName
        description = $script:AppDescription
        items       = @()
    }
}

function Test-BuildInManifest($Manifest, [int]$Build) {
    foreach ($item in $Manifest.items) {
        if ([int]$item.shortVersion -eq $Build) { return $true }
    }
    return $false
}

function Add-ManifestItem($Manifest, [string]$DisplayVersion, [int]$Build,
        [string]$Date, [bool]$IsMandatory, [string]$Url, [string[]]$NoteLines) {
    $changes = @($NoteLines | ForEach-Object {
        [pscustomobject]@{ type = 'feat'; message = $_ }
    })
    $item = [pscustomobject]@{
        version      = $DisplayVersion
        shortVersion = $Build      # JSON number - plugin ItemModel wants int
        date         = $Date
        mandatory    = $IsMandatory
        platform     = 'windows'
        url          = $Url        # must keep trailing /
        changes      = $changes
    }
    $Manifest.items = @($Manifest.items) + @($item)
    $Manifest
}

function Write-Manifest($Manifest, [string]$Path) {
    $json = $Manifest | ConvertTo-Json -Depth 6
    Set-Content -Path $Path -Value $json -Encoding utf8NoBOM
}
```

- [ ] **Step 2: Verify manifest round-trip, number-typed shortVersion, no BOM, duplicate detection**

```powershell
pwsh -NoProfile -Command @'
. .\tool\release.ps1
$tmp = Join-Path $env:TEMP 'esm-manifest-test.json'
Remove-Item $tmp -ErrorAction SilentlyContinue
$m = Read-Manifest $tmp
if ($m.appName -ne 'Enigma Signal Meter') { throw 'wrong appName on fresh manifest' }
if (@($m.items).Count -ne 0) { throw 'fresh manifest items not empty' }
$m = Add-ManifestItem -Manifest $m -DisplayVersion '1.1.2' -Build 5001 `
    -Date '2026-06-12' -IsMandatory $false `
    -Url 'https://www.krkadoni.com/signalmeter/1.1.2/windows/' `
    -NoteLines @('First Windows release')
Write-Manifest $m $tmp
$raw = Get-Content $tmp -Raw
if ($raw -notmatch '"shortVersion":\s*5001\b') { throw 'shortVersion must be an unquoted JSON number' }
if ($raw -notmatch '"url":\s*"[^"]+/windows/"') { throw 'url lost its trailing slash' }
$bytes = [System.IO.File]::ReadAllBytes($tmp)
if ($bytes[0] -eq 0xEF) { throw 'manifest must not start with a BOM' }
$m2 = Read-Manifest $tmp
if (-not (Test-BuildInManifest $m2 5001)) { throw 'existing build 5001 not detected' }
if (Test-BuildInManifest $m2 5002) { throw 'phantom build 5002 detected' }
Remove-Item $tmp
'manifest functions OK'
'@
```

Expected: prints `manifest functions OK`, exit code 0.

- [ ] **Step 3: Commit**

```powershell
git add tool/release.ps1
git commit -m "feat(release): manifest read/append/write with duplicate guard"
```

---

### Task 3: Preflight guards (main flow, part 1)

**Files:**
- Modify: `tool/release.ps1` (append AFTER the dot-source guard line)

- [ ] **Step 1: Append the preflight block at the end of the file**

```powershell
Set-Location $script:RepoRoot

# Preflight ------------------------------------------------------------------
if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) { Fail 'flutter is not on PATH' }
if (-not (Get-Command dart -ErrorAction SilentlyContinue)) { Fail 'dart is not on PATH' }

if (git status --porcelain) { Fail 'working tree is not clean - commit or stash first' }
$branch = git rev-parse --abbrev-ref HEAD
if ($branch -ne 'master') { Fail "current branch is '$branch' - releases are cut from master" }

$constants = Get-Content (Join-Path $script:RepoRoot 'lib/src/constants.dart') -Raw
if (-not $constants.Contains($script:ProductionManifestUrl)) {
    Fail "appArchiveUrl in lib/src/constants.dart is not the production URL $($script:ProductionManifestUrl)"
}

$v = Get-PubspecVersion (Join-Path $script:RepoRoot 'pubspec.yaml')
$distDir = Join-Path $script:RepoRoot "dist\$($v.Build)"
if (Test-Path $distDir) {
    if (-not $Force) { Fail "$distDir already exists (use -Force to rebuild)" }
    Remove-Item -Recurse -Force $distDir
}

$manifest = Read-Manifest $script:ManifestPath
if (Test-BuildInManifest $manifest $v.Build) {
    Fail "build $($v.Build) is already published in $($script:ManifestPath)"
}

Write-Host "Releasing $($script:AppName) $($v.Display)+$($v.Build)" -ForegroundColor Green
```

- [ ] **Step 2: Verify the dirty-tree guard fires**

```powershell
New-Item dirty.tmp -ItemType File | Out-Null
pwsh -NoProfile -File .\tool\release.ps1
$LASTEXITCODE
Remove-Item dirty.tmp
```

Expected: `RELEASE ABORTED: working tree is not clean - commit or stash first`, `$LASTEXITCODE` = `1`. (`dirty.tmp` is untracked, so `git status --porcelain` is non-empty.)

- [ ] **Step 3: Verify the branch guard fires (we are still on the feature branch)**

```powershell
pwsh -NoProfile -File .\tool\release.ps1
$LASTEXITCODE
```

Expected: `RELEASE ABORTED: current branch is 'feature/windows-auto-update' - releases are cut from master`, `$LASTEXITCODE` = `1`. This also proves the clean-tree and PATH checks pass on a clean tree.

- [ ] **Step 4: Commit**

```powershell
git add tool/release.ps1
git commit -m "feat(release): preflight guards"
```

---

### Task 4: Build, package, zip (main flow, part 2)

**Files:**
- Modify: `tool/release.ps1` (append at end of file)

- [ ] **Step 1: Append the build/package/zip block**

```powershell
# Build + package ------------------------------------------------------------
Invoke-Step 'flutter clean' { flutter clean }
Invoke-Step 'flutter pub get' { flutter pub get }
Invoke-Step 'flutter build windows --release' { flutter build windows --release }
Invoke-Step 'desktop_updater:release' { dart run desktop_updater:release windows }
Invoke-Step 'desktop_updater:archive' { dart run desktop_updater:archive windows }

$appFolder  = Join-Path $distDir "enigma_signal_meter-$($v.Display)+$($v.Build)-windows"
$updateTree = Join-Path $distDir "$($v.Display)+$($v.Build)-windows"
if (-not (Test-Path (Join-Path $appFolder 'enigma_signal_meter.exe'))) {
    Fail "expected app folder $appFolder is missing or incomplete"
}
if (-not (Test-Path (Join-Path $updateTree 'hashes.json'))) {
    Fail "expected update tree $updateTree is missing hashes.json"
}

# First-install zip (zip root is the app folder, so extraction is tidy) ------
$zipPath = Join-Path $distDir "enigma_signal_meter-$($v.Display)-windows.zip"
Write-Host '==> zip first-install download' -ForegroundColor Cyan
Compress-Archive -Path $appFolder -DestinationPath $zipPath -Force
```

(`Compress-Archive` is a cmdlet — `$ErrorActionPreference = 'Stop'` already makes its failures fatal; it is deliberately NOT wrapped in `Invoke-Step`, which is for native executables only.)

- [ ] **Step 2: Parse-check the script**

The happy path cannot run until we are on master (Task 7), so verify the file still parses and the functions still load:

```powershell
pwsh -NoProfile -Command ". .\tool\release.ps1; 'parsed OK'"
```

Expected: `parsed OK`, exit code 0.

- [ ] **Step 3: Commit**

```powershell
git add tool/release.ps1
git commit -m "feat(release): cold build, desktop_updater packaging, first-install zip"
```

---

### Task 5: Manifest append + upload bundle + instructions (main flow, part 3)

**Files:**
- Modify: `tool/release.ps1` (append at end of file)

- [ ] **Step 1: Append the final block**

```powershell
# Manifest --------------------------------------------------------------------
$releaseUrl = "$($script:BaseUrl)/$($v.Display)/windows/"
$manifest = Add-ManifestItem -Manifest $manifest -DisplayVersion $v.Display `
    -Build $v.Build -Date (Get-Date -Format 'yyyy-MM-dd') `
    -IsMandatory $Mandatory.IsPresent -Url $releaseUrl -NoteLines $Notes
Write-Manifest $manifest $script:ManifestPath
Write-Host "==> manifest updated: $($script:ManifestPath)" -ForegroundColor Cyan

# Upload bundle ----------------------------------------------------------------
$uploadDir  = Join-Path $distDir 'upload'
$uploadTree = Join-Path $uploadDir "$($v.Display)\windows"
New-Item -ItemType Directory -Force $uploadTree | Out-Null
Copy-Item (Join-Path $updateTree '*') $uploadTree -Recurse
Copy-Item $zipPath $uploadDir
Copy-Item $script:ManifestPath $uploadDir

Write-Host @"

Release $($v.Display)+$($v.Build) staged in $uploadDir

Upload in THIS order:
 1. Contents of  upload\$($v.Display)\windows\
    -> $releaseUrl  (new folder; immutable once published)
 2. upload\enigma_signal_meter-$($v.Display)-windows.zip
    -> wherever the website links the Windows download
 3. upload\app-archive.json
    -> $($script:ProductionManifestUrl)  (REPLACE existing - always LAST)

Server rules: manifest served with Cache-Control: no-cache; version folders
immutable; files byte-exact (no CDN compression/transformation).

Afterwards, record the release in git:
  git add tool/app-archive.json
  git commit -m "chore(release): publish $($v.Display)+$($v.Build) windows"
  git tag v$($v.Display)+$($v.Build)
"@ -ForegroundColor Green
```

- [ ] **Step 2: Parse-check again**

```powershell
pwsh -NoProfile -Command ". .\tool\release.ps1; 'parsed OK'"
```

Expected: `parsed OK`, exit code 0.

- [ ] **Step 3: Commit**

```powershell
git add tool/release.ps1
git commit -m "feat(release): manifest append, upload bundle, upload instructions"
```

---

### Task 6: `docs/RELEASING.md` runbook

**Files:**
- Create: `docs/RELEASING.md`

- [ ] **Step 1: Create the runbook**

````markdown
# Windows release & auto-update publishing

Every Windows release is published to www.krkadoni.com so installed apps
self-update. The app reads
`https://www.krkadoni.com/signalmeter/app-archive.json` at startup
(Windows only) and offers any newer build.

## Cutting a release

Prerequisites: Windows, Flutter toolchain on PATH, PowerShell 7, clean
working tree **on `master`**.

1. Bump `version:` in `pubspec.yaml`. The build number after `+` MUST
   increase — it is the integer the updater compares (`1.1.2+5001` ->
   `1.1.3+5002`). Commit the bump.
2. Run the release script from the repo root:

   ```powershell
   pwsh -NoProfile -File tool\release.ps1 -Notes "Short English note per change"
   ```

   - `-Notes` takes one or more strings; each becomes a release-note line
     in the update dialog. Notes are English-only by design.
   - `-Mandatory` removes "Later" from the update dialog (emergency lever).
   - `-Force` rebuilds an existing `dist\<build>` output.

   The script aborts early on any guard violation (dirty tree, wrong
   branch, non-production `appArchiveUrl` in `lib/src/constants.dart`,
   build number already published) and otherwise produces
   `dist\<build>\upload\` plus an updated `tool/app-archive.json`.
3. Upload, **in this order** (never advertise files that are not in place):
   1. contents of `upload\<ver>\windows\` ->
      `https://www.krkadoni.com/signalmeter/<ver>/windows/`
   2. `upload\enigma_signal_meter-<ver>-windows.zip` -> the website's
      download location (first-install users)
   3. `upload\app-archive.json` -> replaces
      `https://www.krkadoni.com/signalmeter/app-archive.json` — **LAST**
4. Record the release:

   ```powershell
   git add tool/app-archive.json
   git commit -m "chore(release): publish <ver>+<build> windows"
   git tag v<ver>+<build>
   git push origin master --tags
   ```

## Server rules

- `app-archive.json` must be served with `Cache-Control: no-cache`
  (a cached stale manifest means clients never see updates).
- Version folders are immutable; long caching is fine there.
- Files must be served byte-exact — no CDN compression rewriting or
  transformation; the updater verifies Blake2b hashes byte-for-byte.
- Keep older version folders online until their user base has moved on;
  the updater always jumps straight to the newest entry.

## Verifying a release

- Extract the zip to a fresh folder; the app must launch.
- Run the released exe with the live manifest uploaded: no update dialog
  may appear (it is the newest version — `versionCheck` returns null).
- A real over-the-wire update (download -> swap -> relaunch) can only be
  tested when the NEXT release is published: install the previous version,
  start it, accept the update.
````

- [ ] **Step 2: Commit**

```powershell
git add docs/RELEASING.md
git commit -m "docs(release): Windows release runbook"
```

---

### Task 7: Merge `feature/windows-auto-update` into master

The release is cut from master (user decision in the spec). Confirm the branch is green, then merge.

- [ ] **Step 1: Confirm tests and analyzer are green on the branch**

```powershell
flutter test
flutter analyze
```

Expected: all tests pass; `flutter analyze` shows no NEW items beyond the pre-existing baseline (56 info/warning items, zero errors, as recorded in the auto-update plan).

- [ ] **Step 2: Merge into master**

```powershell
git checkout master
git pull origin master
git merge --no-ff feature/windows-auto-update -m "Merge feature/windows-auto-update: Windows auto-update + release tooling"
```

Expected: merge commit created, no conflicts (master has not moved since the branch was cut — if it HAS, stop and resolve deliberately, do not improvise).

- [ ] **Step 3: Push master**

```powershell
git push origin master
```

---

### Task 8: Cut release 1.1.2+5001

- [ ] **Step 1: Delete the stale E2E test artifacts**

```powershell
Remove-Item -Recurse -Force dist\5002
```

(`dist\5002` is the leftover 1.1.3+5002 build used for E2E update testing on 2026-06-11; its binary may contain a localhost manifest URL and must never ship.)

- [ ] **Step 2: Run the release script**

```powershell
pwsh -NoProfile -File tool\release.ps1 -Notes "First Windows release with built-in auto-update"
```

Takes 5-15 minutes (cold flutter build). Expected to end with the green "Release 1.1.2+5001 staged in ...dist\5001\upload" instructions block. This run is also the proof that all preflight guards pass on master.

- [ ] **Step 3: Verify the outputs**

```powershell
Test-Path dist\5001\enigma_signal_meter-1.1.2+5001-windows\enigma_signal_meter.exe
Test-Path dist\5001\1.1.2+5001-windows\hashes.json
Test-Path dist\5001\enigma_signal_meter-1.1.2-windows.zip
Test-Path dist\5001\upload\1.1.2\windows\hashes.json
Test-Path dist\5001\upload\enigma_signal_meter-1.1.2-windows.zip
Test-Path dist\5001\upload\app-archive.json
Get-Content tool\app-archive.json -Raw
```

Expected: six `True` lines; the manifest contains exactly one item with `"version": "1.1.2"`, `"shortVersion": 5001` (unquoted number), `"mandatory": false`, `"url": "https://www.krkadoni.com/signalmeter/1.1.2/windows/"`, and one `changes[]` entry with the release note.

- [ ] **Step 4: Verify the zip launches (operator step)**

```powershell
Expand-Archive dist\5001\enigma_signal_meter-1.1.2-windows.zip -DestinationPath $env:TEMP\esm-release-check -Force
& "$env:TEMP\esm-release-check\enigma_signal_meter-1.1.2+5001-windows\enigma_signal_meter.exe"
```

Human verifies: the app starts and renders normally. (No update dialog is expected — the manifest is not uploaded yet, and a failed check is silent by design.) Close the app afterwards.

- [ ] **Step 5: Record the release in git**

```powershell
git add tool/app-archive.json
git commit -m "chore(release): publish 1.1.2+5001 windows"
git tag v1.1.2+5001
git push origin master --tags
```

---

### Task 9: Upload and post-upload verification (operator-driven)

No file changes in this task.

- [ ] **Step 1: Upload (human, manual)**

Follow the script's printed instructions, in order:
1. contents of `dist\5001\upload\1.1.2\windows\` -> `https://www.krkadoni.com/signalmeter/1.1.2/windows/`
2. `dist\5001\upload\enigma_signal_meter-1.1.2-windows.zip` -> website download location
3. `dist\5001\upload\app-archive.json` -> `https://www.krkadoni.com/signalmeter/app-archive.json` (LAST)

- [ ] **Step 2: Verify the server serves the release correctly**

```powershell
curl.exe -sI https://www.krkadoni.com/signalmeter/app-archive.json
curl.exe -sI https://www.krkadoni.com/signalmeter/1.1.2/windows/hashes.json
```

Expected: both return `HTTP/... 200`. Check the manifest response for `Cache-Control: no-cache` — if absent, configure it server-side (stale manifest = clients never see updates).

```powershell
$live = (Invoke-WebRequest 'https://www.krkadoni.com/signalmeter/app-archive.json').Content
$local = Get-Content tool\app-archive.json -Raw
if ($live -ne $local) { 'MISMATCH - server is transforming the file' } else { 'manifest byte-identical' }
```

Expected: `manifest byte-identical`. A mismatch means CDN/compression transformation — must be fixed before users update (hash verification is byte-exact).

- [ ] **Step 3: Prove the production wiring end-to-end (operator step)**

Launch the released exe again (from the Task 8 Step 4 extract). Expected: app starts normally and NO update dialog appears — the live manifest's `shortVersion` 5001 equals the running build, so `versionCheck` returns null. This is the strongest test possible until a second release exists; note that a real download -> swap -> relaunch test happens when the next release is cut.

---

## Self-review notes

- Spec coverage: preflight guards (Task 3), build/package/zip (Task 4), manifest + bundle + instructions (Task 5), runbook (Task 6), merge-first decision (Task 7), first-release one-offs incl. `dist\5002` deletion (Task 8), upload ordering + server rules + up-to-date verification (Task 9). Negative guard tests (dirty tree, wrong branch, duplicate build, bad version) in Tasks 1-3.
- The happy path is intentionally exercised only once, on master, as the spec designates the first release run as the integration test.
