# Windows Platform Support — Design

**Date:** 2026-06-11
**Status:** Approved by user (brainstorming session)

## Goal

Add Windows desktop as a build target for Enigma Signal Meter with all existing
features functional. Store/installer packaging is explicitly deferred to a
follow-up effort ("start dev, ship later"). The deliverable is a working
`flutter build windows --release` output folder, runnable and zip-able.

## Decisions (from brainstorming Q&A)

| Topic | Decision |
|---|---|
| Goal | Full functionality now; packaging/distribution later |
| Desktop UX | Minimal — existing mobile UI in a resizable window, sane size defaults |
| Window shape | Mobile-like portrait: default 450×800 (9:16), minimum 360×640 |
| Screenshot save | Auto-save to the user's Pictures folder (mirrors mobile save-to-gallery) |
| Saved message | Reuse existing "Screenshot successfully saved to gallery" message — no new i18n key |
| Stream playback | Launch VLC if installed; otherwise fall back to the default URL handler |
| Code structure | Approach A: inline `Platform.isWindows` branches + small utils (matches existing codebase style) |

## Why Approach A (inline branches)

The codebase already branches inline on `Platform.isAndroid` / `Platform.isIOS`.
There are only three divergence points, so a `PlatformServices` abstraction
(Approach B) or conditional imports (Approach C) would be YAGNI and would
refactor working mobile code in a shipping store app. Approach A keeps the
mobile code paths untouched — lowest regression risk.

## Plugin compatibility audit

Already Windows-capable: `gal` (verified: its Windows implementation saves via
WinRT `KnownFolders::PicturesLibrary()`), `wakelock_plus`, `url_launcher`,
`shared_preferences`, `package_info_plus`, `share_plus`, `flutter_tts`.

Pure Dart/Flutter (no platform code): `enigma_web`, `redux`/`flutter_redux`/
`flutter_redux_navigation`, `fl_chart`, `photo_view`, `showcaseview`,
`percent_indicator`, `auto_size_text`, `another_flushbar`, `xml`, `intl`.

Never invoked on Windows (guarded or Android-build-only), so inert at runtime:
`android_intent_plus`, `permission_handler`.

Build note: the `gal` and `permission_handler` Windows plugins use legacy
`/await` MSVC coroutines; VS 2026 requires
`-D_SILENCE_EXPERIMENTAL_COROUTINE_DEPRECATION_WARNINGS` in
`windows/CMakeLists.txt` (added during scaffolding).

## Section 1 — Platform enablement & app shell

**Scaffolding.** `flutter create --platforms=windows .` generates the
`windows/` CMake runner. Build prerequisite: Visual Studio 2022 with the
"Desktop development with C++" workload.

**Window behavior** (edits to the generated runner):
- Title: "Enigma Signal Meter".
- Default size **450×800** logical pixels (9:16 portrait, phone-like, since the
  app is portrait-only on mobile).
- Minimum size **360×640** (same ratio), enforced via a `WM_GETMINMAXINFO`
  handler in `win32_window.cpp` (~10 lines of C++). DPI scaling: the template
  already scales the initial size by the monitor DPI factor; the min size must
  be scaled the same way.
- Freely resizable above the minimum. No size/position persistence (deferred).

**App icon.** Extend the `flutter_launcher_icons` config in `pubspec.yaml` with
`windows: true`, source image `assets/icons/esm_icon_1024_1024_iOS.png`
(the square, non-adaptive variant), generating
`windows/runner/resources/app_icon.ico`.

**New Dart dependency: `win32_registry`** (pure-Dart FFI bindings; no native
toolchain impact). Used only for reading the VLC install path from the
registry. (Originally `win32` was also planned for Pictures-folder resolution;
that became unnecessary once `gal`'s native Windows support was verified —
see 2.1.)

**Dart entry point.** No changes to `lib/main.dart` — verified: the
`SystemChrome.setSystemUIOverlayStyle` call is a no-op on desktop and there are
no orientation locks.

## Section 2 — Feature divergence points

### 2.1 Screenshot save → Pictures folder

**No code change needed** (verified during implementation): `gal` ships a
Windows implementation that saves via WinRT `KnownFolders::PicturesLibrary()`
— exactly the chosen auto-save-to-Pictures behavior, with OneDrive known-folder
redirection handled by Windows. The existing
`Gal.hasAccess`/`requestAccess`/`putImageBytes` code and the existing
`ScreenshotSavedInfoMessageEvent` message work unchanged on all platforms.
Verified by the manual smoke checklist. (This supersedes the original
`screenshot_saver.dart` + `win32`/`SHGetKnownFolderPath` design — that
dependency is no longer needed.)

### 2.2 Stream playback → VLC with default-handler fallback

New util `lib/src/utils/vlc_launcher.dart` (Windows-only logic), called from a
new `else if (Platform.isWindows)` branch in `more_viewmodel.dart` (currently
line 145), placed before the existing iOS `else`:

- Locate `vlc.exe`: registry `HKLM\SOFTWARE\VideoLAN\VLC` → `InstallDir`
  (including the `WOW6432Node` variant), then probe
  `C:\Program Files\VideoLAN\VLC\vlc.exe` and the `(x86)` equivalent.
- Found → `Process.start(vlcPath, [streamUri], mode: ProcessStartMode.detached)`.
- Not found → `launchUrl(streamUri)` and let the default handler take it — no
  error message. If `launchUrl` itself fails, log and do nothing.

### 2.3 Existing platform checks — audited

- **`home_view.dart` — change required (found during testing):** the
  `Platform.isAndroid`-gated FAB (lines 116 and 103) is the **add-profile (+)
  button**, and the iOS alternative in `profiles_view.dart` is
  `Platform.isIOS`-gated — so Windows had no way to add a profile at all.
  Fix: widen both `home_view.dart` conditions to
  `Platform.isAndroid || Platform.isWindows` so Windows gets the Material FAB
  (and its showcase). `profiles_view.dart` stays iOS-only.
- `PlatformAdaptiveProgressIndicator` (`Platform.isIOS`) → Material spinner on
  Windows. Correct for a Material-themed app.
- `profiles_view.dart` `Platform.isIOS` branch → non-iOS branch is correct.
- `tts_utils.dart` speech rate → Windows gets the non-iOS rate (1.0);
  `flutter_tts` has a Windows backend. Verify rate during smoke testing.
- `wakelock_plus` works on Windows and is desirable (keeps a laptop screen on
  during dish alignment).

## Section 3 — Testing & scope boundaries

**Testing.**
- `flutter analyze` clean; existing test suite passes (mobile code paths are
  untouched by design, so green tests demonstrate zero mobile regressions).
- New unit tests for the testable logic in the new util: VLC path discovery
  with injectable probe/registry seams.
- Manual smoke checklist on Windows against a real receiver: launch, connect
  profile, signal monitoring + chart, TTS announcement, screenshot
  fetch/save/share, stream-to-VLC (and fallback with VLC absent), wakelock
  during monitoring, window resize down to the minimum.

**Out of scope (deferred to "ship later"):** MSIX/Microsoft Store packaging,
installer, code signing, window size persistence, keyboard shortcuts,
wide-screen desktop layouts, macOS/Linux support, CI for Windows builds.

**Docs:** CHANGES.TXT entry; one-line Windows mention in README.
