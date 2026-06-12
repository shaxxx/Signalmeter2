# First Windows Release + Release Script — Design

**Date:** 2026-06-12
**Status:** Approved by user (brainstorming session)
**Builds on:** `docs/superpowers/specs/2026-06-11-windows-auto-update-design.md`,
which defines the hosting contract, manifest format, and the
`desktop_updater` release/archive commands this design automates.

## Goal

Ship Enigma Signal Meter **1.1.2+5001** as the first public Windows release,
and make every future release a one-command ritual via a new PowerShell
script that owns the error-prone parts: manifest correctness, the
`shortVersion` = build-number rule, upload ordering, and stale-test-config
guards.

## Decisions (from brainstorming Q&A)

| Topic | Decision |
|---|---|
| Deliverable | Scripted release (`tool/release.ps1`), then run it for this first release |
| Version | Current pubspec version `1.1.2+5001` — no bump. The leftover `dist\5002` E2E test build is deleted, never shipped |
| Upload | Script stops at an upload-ready bundle; uploading to www.krkadoni.com stays manual (matches auto-update spec's out-of-scope) |
| Source branch | Merge `feature/windows-auto-update` into master first; the release is cut from master |
| Script language | PowerShell — the flow is Windows-only by nature; zip (`Compress-Archive`) and JSON (`ConvertTo-Json`) are built in, zero new dependencies |

## Components

### `tool/release.ps1`

One command, no parameters required for the normal case.

**Parameters:**

- `-Notes <string[]>` — release-note lines; each becomes a `changes[]` entry
  in the manifest item. Default: empty list.
- `-Mandatory` — switch; sets `mandatory: true` on the manifest item (the
  emergency lever from the auto-update spec).
- `-Force` — switch; allows overwriting an existing `dist\<build>\` output.

**Steps, in order:**

1. **Preflight** — all checks pass or the script aborts before touching
   anything:
   - working tree clean (`git status --porcelain` empty);
   - current branch is `master`;
   - `flutter` and `dart` resolvable on PATH;
   - `appArchiveUrl` in `lib/src/constants.dart` equals the production
     `https://www.krkadoni.com/signalmeter/app-archive.json` — guards the
     localhost-manifest leftover hazard observed during E2E testing;
   - `version` parsed from `pubspec.yaml` as `<ver>+<build>` (both parts
     required);
   - `dist\<build>\` does not already exist (unless `-Force`);
   - `<build>` does not already appear as a `shortVersion` in the canonical
     manifest (duplicate-release guard).
2. **Build** — `flutter clean`, `flutter pub get`,
   `flutter build windows --release`. A cold build is slow but removes any
   chance of stale artifacts in a shipped binary.
3. **Package** — `dart run desktop_updater:release windows`, then
   `dart run desktop_updater:archive windows`. Output (plugin convention):
   - `dist\<build>\enigma_signal_meter-<ver>+<build>-windows\` — full app
     (first-install distribution);
   - `dist\<build>\<ver>+<build>-windows\` — update tree with Blake2b
     `hashes.json`.
4. **Zip** — `Compress-Archive` of the full-app folder →
   `dist\<build>\enigma_signal_meter-<ver>-windows.zip`, the first-install
   download for the website (auto-update only reaches users who already have
   the app).
5. **Manifest** — the canonical `app-archive.json` lives in the repo at
   `tool/app-archive.json` (git history doubles as release history). The
   script appends one item:

   ```json
   {
     "version": "<ver>",
     "shortVersion": <build>,
     "date": "<today, yyyy-MM-dd>",
     "mandatory": false,
     "platform": "windows",
     "url": "https://www.krkadoni.com/signalmeter/<ver>/windows/",
     "changes": [ { "type": "feat", "message": "<note>" } ]
   }
   ```

   Rules carried over from the auto-update spec: `shortVersion` is the
   **integer build number** as a JSON number, not a string (the plugin's
   `ItemModel` declares it `int`; the proven E2E manifest used `5002`
   unquoted); `version` is the display string; the URL path uses the
   display version only — no `+` in URLs — and keeps the trailing slash. The file is read with `ConvertFrom-Json` and written back in a
   single write (UTF-8 **without** BOM), so a malformed manifest can never
   be produced. If `tool/app-archive.json` does not exist yet (this first
   release), the script creates it with the `appName`/`description` wrapper
   (matching the manifest shape proven in E2E testing) and one item.
6. **Upload bundle** — assemble `dist\<build>\upload\` mirroring the server
   layout:

   ```
   upload\
     app-archive.json
     <ver>\windows\            (copy of the update tree incl. hashes.json)
     enigma_signal_meter-<ver>-windows.zip
   ```

   Then print ordered upload instructions: (1) upload the `<ver>/windows/`
   tree, (2) publish the zip wherever the site links downloads, (3) replace
   `app-archive.json` **last** — clients must never see a manifest entry
   whose files are not yet in place. Repeat the server rules from the
   auto-update spec: manifest served `Cache-Control: no-cache`; version
   folders immutable; files byte-exact (no CDN transformation).

### `docs/RELEASING.md`

One-page runbook: prerequisites (Windows, Flutter toolchain), the
one-command invocation with examples (`-Notes`, `-Mandatory`), what the
script outputs, the manual upload steps, and the verification checklist
below. Points at the auto-update spec for the contract details.

## First-release one-offs (manual, around the script)

1. Merge `feature/windows-auto-update` into master (normal branch-finishing
   flow — review, merge, delete branch).
2. Delete the stale `dist\5002\` E2E test artifacts.
3. On master, run `tool/release.ps1 -Notes "..."` → produces the
   `dist\5001\` bundle for 1.1.2+5001.
4. Upload the bundle per the printed instructions; link the zip from the
   website (website change is outside this repo).

## Error handling

- Every external command (`git`, `flutter`, `dart`) is exit-code-checked;
  non-zero aborts with a message naming the failed step.
- Preflight runs before any mutation; a failed preflight leaves the repo and
  `dist\` untouched.
- The manifest update is a single atomic write (the bundle assembly that
  follows only copies files); an abort mid-script can never leave a
  half-written manifest.

## Testing

- The first release run **is** the script's integration test, verified step
  by step:
  - zip extracts to a fresh folder and the exe launches;
  - `hashes.json` present in the update tree;
  - `tool/app-archive.json` parses and contains exactly one item with
    `shortVersion` `"5001"`;
  - after upload: the released exe, pointed at the live manifest, reports
    up-to-date (`versionCheck` returns null when current) — this proves the
    production wiring end-to-end short of an actual update.
- A true over-the-wire update (download → swap → relaunch) only becomes
  testable at the **second** release; planned, not discovered.
- Preflight guards are exercised negatively during implementation (dirty
  tree, wrong branch, duplicate build number) before the real run.

## Out of scope

Automated upload to krkadoni.com, installer/MSIX packaging, code signing,
CI release pipeline, website download-page changes, macOS/Linux releases.
