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
