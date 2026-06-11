# Windows Auto-Update — Design

**Date:** 2026-06-11
**Status:** Approved by user (brainstorming session)
**Reference implementation:** BRKO app (`C:\zeba\Kase\Kase2023\Ugostiteljska\flutter`),
spec `docs/superpowers/specs/2026-05-19-brko-flutter-desktop-auto-update-design.md`
in that repo. Signal Meter ports BRKO's `desktop_updater`-plugin architecture with
the domain changed to krkadoni.com and BRKO's Riverpod orchestration replaced by a
self-contained dialog.

## Goal

Give the Windows desktop build of Enigma Signal Meter a true in-place auto-update:
check at startup, offer the update, download only changed files (hash-verified),
then exit–swap–relaunch via the plugin's native helper. No manual zip copying.

## Decisions (from brainstorming Q&A)

| Topic | Decision |
|---|---|
| Platforms | Windows only. Mobile updates stay with Play Store / App Store; mobile code untouched. |
| Mechanism | `desktop_updater` plugin (same as BRKO, prerelease 2.x), isolated behind a seam |
| Enforcement | Optional prompt (Update / Later) by default; the manifest's per-release `mandatory: true` removes Later and blocks dismissal — an emergency lever |
| Check cadence | Startup only; `update_checker` wraps `checkAvailability()` in a 5 s `.timeout()`; silent fail-open on any error |
| i18n | All dialog strings localized in all 10 locales, length-balanced (see i18n section) |
| Hosting | `https://www.krkadoni.com/signalmeter/app-archive.json` + `/signalmeter/<version>/windows/` file trees |
| Architecture | BRKO's seam pattern (interface + sole plugin importer) + self-contained dialog with local state (no Redux slice — progress is dialog-local, not app state) |
| Non-writable install dir | One-time elevated `icacls` grant (current user, Modify) offered in-dialog; warning with manual fallback if declined. No installer exists (neither has BRKO) |

## Components

**New dependencies:** `desktop_updater` `^2.0.0-dev.1` (the version BRKO ships
in production; prerelease — the seam isolates the risk to one file) and
`version` (semver compare). No `http`, no `path_provider` — the plugin downloads, hashes and
stages by itself. `package_info_plus` (current version) is already a dependency.

**New files (Signal Meter conventions):**

- `lib/src/model/desktop_updater.dart` — the seam, pure Dart, no plugin import:

  ```dart
  abstract interface class DesktopUpdater {
    /// Reads the remote manifest; latest == null when no Windows entry exists
    /// or the check fails inside the plugin.
    Future<DesktopUpdateAvailability> checkAvailability();

    /// Downloads + stages changed files. Emits Downloading(0..1) events, then
    /// exactly one Staged OR one Failed, then closes. Failures are events,
    /// never stream errors.
    Stream<DesktopUpdateProgress> startUpdate();

    /// Exits the app; the native helper swaps staged files and relaunches.
    /// Only valid after a Staged event.
    Future<void> restartAndApply();
  }

  class DesktopUpdateAvailability {
    final Version? latest;
    final bool isMandatory;
    final String? releaseNotes;
  }

  sealed class DesktopUpdateProgress {}
  class DesktopUpdateDownloading extends DesktopUpdateProgress { final double progress; }
  class DesktopUpdateStaged extends DesktopUpdateProgress { final Version newVersion; }
  class DesktopUpdateFailed extends DesktopUpdateProgress { final String message; }
  ```

- `lib/src/utils/desktop_updater_client.dart` — production implementation; the
  **only file in the repo importing `package:desktop_updater`** (BRKO's rule).
  Call-sequence contract identical to BRKO's client:
  1. `checkAvailability()` → `plugin.versionCheck(appArchiveUrl)` → remembers
     the matched `ItemModel` (its `version` parsed as semver; `mandatory` and
     joined `changes` mapped into `DesktopUpdateAvailability`).
  2. `startUpdate()` → `plugin.updateApp(remoteUpdateFolder: item.url,
     changedFiles: item.changedFiles)` → maps the plugin stream to
     `Downloading` events, captures the last reported staging directory, ends
     with `Staged` (or `Failed` on any exception / missing staging dir).
  3. `restartAndApply()` → `plugin.installUpdate(stagingPath, removedFiles)`;
     throws `StateError` if called before a `Staged` event.

- `lib/src/ui/update/update_dialog.dart` — one self-contained `StatefulWidget`
  dialog owning a local state machine:
  - **prompt**: title + "Version X.Y.Z is available." + release notes from the
    manifest (scrollable if long) + buttons Update / Later. When
    `isMandatory`, Later is omitted and `barrierDismissible` stays false.
  - **downloading**: linear progress bar fed by `startUpdate()` events.
  - **restart**: "Update downloaded. Restart to apply." + Restart button →
    `restartAndApply()`.
  - **error**: translated failure line + Close. No in-dialog retry — the next
    app start retries naturally.

- `lib/src/ui/update/update_checker.dart` — startup hook:
  `maybeShowUpdateDialog(BuildContext, {DesktopUpdater?})`. Guard
  `Platform.isWindows`, call `checkAvailability()` in a try/catch with a 5 s
  timeout (failure → log, return), and show the dialog when `latest != null`
  (the plugin already compared build numbers; see hosting section). Injectable
  updater for tests.

- `lib/src/utils/install_dir_access.dart` — writability probe + one-time
  elevated ACL grant; see "Install-folder writability" below.

- `lib/src/constants.dart` — add
  `const String appArchiveUrl = 'https://www.krkadoni.com/signalmeter/app-archive.json';`

**Trigger:** the home view's first-build hook (where showcase logic already
runs) calls `maybeShowUpdateDialog(context)` once. Mobile never reaches any of
this; BRKO ships the same unconditional plugin import on Android/iOS, proving
it compiles harmlessly there.

## i18n

All dialog strings go through the existing `MessageProvider` / ARB /
`intl_translation` workflow in **all 10 locales** (en, ca, de, es, fr, hr, it,
nl, ru, zh). About 9 new keys:

| Key (indicative) | English |
|---|---|
| `updateAvailableTitle` | Update available |
| `updateAvailableBody` | Version {version} is available. |
| `updateActionUpdate` | Update |
| `updateActionLater` | Later |
| `updateDownloading` | Downloading update… |
| `updateRestartBody` | Update downloaded. Restart to apply. |
| `updateActionRestart` | Restart |
| `updateFailedBody` | Update failed. |
| `updateActionClose` | Close |
| `updatePermissionBody` | The app folder is not writable. Grant permission to enable updates. |
| `updateActionGrant` | Allow |
| `updatePermissionFailedBody` | Permission was not granted. Move the app to a writable folder, or run it once as administrator. |

**Translation length rule (user requirement):** every locale's string stays
within roughly ±30% of the English length; button labels are one word (two at
most) in every language. No locale gets a sentence where another gets a single
word. Reuse existing keys (e.g. an existing Close/Cancel label) where one
already fits instead of minting duplicates. The dialog wraps body text and
sizes buttons flexibly, so residual variance is safe.

**Deliberate exception:** release notes come from the manifest verbatim and are
**not localized** — authored once per release (English suggested).

## Hosting contract & release ritual (krkadoni.com)

Per release:

1. `flutter build windows --release`
2. `dart run desktop_updater:release windows` (release build staged into
   `dist\<build>\<name>-<ver>+<build>-windows\`), then
   `dart run desktop_updater:archive windows` → upload tree
   `dist\<build>\<ver>+<build>-windows\` with Blake2b `hashes.json`.
   (Corrected during planning: the plugin CLI takes a platform argument and a
   `dist/` convention, not `--input/--output` flags as BRKO's spec sketched.)
3. Upload the tree to `https://www.krkadoni.com/signalmeter/<version>/windows/`
4. Update `https://www.krkadoni.com/signalmeter/app-archive.json` **last** —
   append one `items[]` entry:

   ```json
   {
     "appName": "Enigma Signal Meter",
     "items": [
       {
         "version": "1.2.0",
         "shortVersion": "1.2.0",
         "date": "2026-06-11",
         "mandatory": false,
         "platform": "windows",
         "url": "https://www.krkadoni.com/signalmeter/1.2.0/windows/",
         "changes": [
           { "type": "feat", "message": "Example release note" }
         ]
       }
     ]
   }
   ```

   Corrected during planning (verified in plugin source): `shortVersion` is
   the **integer build number** (the part after `+` in pubspec's version, read
   from the exe's ProductVersion resource) and is what the plugin compares;
   `version` is the display string. `versionCheck` returns null when up to
   date, so "update available" simply means `latest != null` — the app does
   not re-compare versions itself.

**Server rules (BRKO-proven):** the manifest is served with
`Cache-Control: no-cache` (stale manifest = clients never see updates);
per-version folders are immutable and may cache long; files must be served
**byte-exact** — CDN compression rewriting or transformation breaks Blake2b
verification.

## Install-folder writability (ACL handling)

The plugin's helper swaps files inside the install folder, so that folder must
be writable by the current user. Usually true (users run the app from an
unzipped folder), but not when someone parks it under `C:\Program Files`.
There is no installer to fix ACLs (BRKO has none either — its spec only lists
the ACL fix as an open downstream prerequisite), so Signal Meter handles it
in-app with a **one-time ACL grant**:

- `lib/src/utils/install_dir_access.dart` — two functions:
  - `isInstallDirWritable()` — probes `File(Platform.resolvedExecutable).parent`
    by creating and deleting a temp file (tests effective ACLs, not
    attributes).
  - `grantInstallDirAccess()` — launches a single elevated `icacls` (UAC
    prompt) granting the **current user** (not the Users group) Modify rights
    with inheritance on the app folder:
    `icacls "<appDir>" /grant "<user>":(OI)(CI)M`, waits for it to finish,
    then re-probes and returns the probe result (the probe is the source of
    truth, not exit codes).

- Dialog behavior: the prompt state probes writability first. If blocked, the
  body gains an explanation line and the Update button is replaced by a
  **Grant permission** button (Later/dismissal rules unchanged, still governed
  by `mandatory`). Grant success → the prompt returns with the normal Update
  button. UAC declined or icacls failure → an inline warning with the manual
  fallback (move the app to a writable folder, or run it once as
  administrator); the Grant button stays for retry.

- The grant is permanent — future updates skip straight to the normal flow.
  The app itself never runs elevated; only the one icacls process does.

## Error handling

- Startup check failure (offline, DNS, bad manifest) → log, continue silently.
  The user is never bothered by a failed check.
- Download/staging failure → dialog error state with Close; retry happens on
  next launch. Failures arrive as `Failed` events, never stream errors.
- `restartAndApply()` is only reachable from the restart state (after
  `Staged`); calling it earlier is a `StateError` by contract.

## Testing

- **Unit:** version-compare decision in `update_checker` (newer / equal /
  older / null latest / check throws) with a `FakeDesktopUpdater`.
- **Widget:** all dialog states driven by the fake (prompt incl.
  mandatory-hides-Later, permission-blocked prompt with Grant button,
  downloading progress, restart button calls `restartAndApply()` once, error
  state) — no plugin, no network. Writability/grant seams injected as
  functions so widget tests cover both probe outcomes.
- **Unit:** `isInstallDirWritable()` probe logic against temp directories
  (writable and read-only). The elevated grant itself is manual-only (UAC).
- **Manual E2E (BRKO's method):** serve a test manifest + archived tree from
  localhost, point a debug build at it, and perform a real version-bump
  upgrade on the dev machine: exit → file swap → relaunch at the new version.
- `flutter analyze` stays at the pre-existing baseline; `flutter test` green;
  one Android debug build to prove mobile is unaffected by the new
  dependencies.

## Out of scope

Installer/MSIX packaging (deferred phase), macOS/Linux update paths,
mid-session update polling, auto-restart without a user click, localized
release notes, automated release/upload pipeline.
