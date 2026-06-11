# Windows Platform Support Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add Windows desktop as a fully functional build target for Enigma Signal Meter (no store packaging yet).

**Architecture:** Scaffold the standard Flutter Windows runner, then handle the platform divergence points with inline `Platform.isWindows` branches: widen the add-profile FAB gate to include Windows, and add a `VlcLauncher` util (VLC discovery + default-handler fallback) for streaming. Screenshot save needs no change — `gal` ships a native Windows implementation that saves to the Pictures library (verified in its source). Mobile code paths stay logically equivalent.

**Tech Stack:** Flutter (Windows desktop), C++ runner template, `win32_registry` (VLC install path), existing plugins (`gal`, `share_plus`, `url_launcher`, `wakelock_plus`, `flutter_tts` — all verified Windows-capable or correctly guarded).

**Spec:** `docs/superpowers/specs/2026-06-11-windows-platform-support-design.md`

---

## Context for the engineer

- This is a shipping Play Store / App Store Flutter app. **Do not change mobile behavior.** The plan is designed so mobile code paths remain logically identical.
- The app is portrait-only on mobile; the Windows window mimics a phone: default 450×800 logical px, minimum 360×640.
- All commands below are PowerShell, run from the repo root `c:\Users\isako\source\repos\Signalmeter2`.
- The working tree already has uncommitted changes to `CHANGES.TXT` and `pubspec.yaml` (unrelated release notes work). **Always `git add` specific files, never `git add -A`.**
- `flutter analyze` has a pre-existing baseline of 56 info/warning items (zero errors). "Analyze clean" below means **no new issues relative to that baseline**. `flutter test` (6 tests) must stay green after every task.
- Existing tests live under `test/unit/` and `test/widget/` — new unit tests go in `test/unit/utils/`.
- `windows/CMakeLists.txt` carries a `-D_SILENCE_EXPERIMENTAL_COROUTINE_DEPRECATION_WARNINGS` define (added in Task 1): the `gal`/`permission_handler` Windows plugins use legacy `/await` coroutines that VS 2026's MSVC otherwise rejects. Do not remove it.

---

### Task 1: Scaffold the Windows runner

**Files:**
- Create: `windows/` (generated — runner C++ project, CMake files)
- Modify: `.metadata` (updated by `flutter create`)

- [ ] **Step 1: Verify toolchain**

Run: `flutter doctor`
Expected: `[√] Visual Studio - develop Windows apps` line present. If it is missing, stop and report — Visual Studio 2022 with the "Desktop development with C++" workload must be installed first.

- [ ] **Step 2: Enable the Windows desktop target (idempotent)**

Run: `flutter config --enable-windows-desktop`
Expected: `Setting "enable-windows-desktop" value to "true".` or already-enabled silence.

- [ ] **Step 3: Generate the runner**

Run: `flutter create --platforms=windows --project-name enigma_signal_meter .`
Expected: output ends with `All done!`; a new `windows/` directory exists containing `runner/main.cpp`, `runner/win32_window.cpp`, `CMakeLists.txt`.

- [ ] **Step 4: Confirm nothing unrelated changed**

Run: `git status --porcelain`
Expected: new `windows/` files and possibly a modified `.metadata`. The pre-existing modifications (`CHANGES.TXT`, `pubspec.yaml`, `docs/playstore-changelog-1.1.2.txt`) are untouched. If `flutter create` touched any other tracked file (e.g. regenerated `README.md` or `.gitignore`), restore it with `git checkout -- <file>`.

- [ ] **Step 5: First run on Windows**

Run: `flutter run -d windows`
Expected: the app builds (first build takes minutes) and the familiar UI opens in a 1280×720 window titled `enigma_signal_meter`. Close the window / press `q` to quit. (Screenshot save and stream playback are not Windows-aware yet — that's Tasks 4–5.)

- [ ] **Step 6: Commit**

```powershell
git add windows .metadata
git commit -m "feat(windows): scaffold Windows desktop runner"
```

---

### Task 2: Phone-like window — title, default size, minimum size

**Files:**
- Modify: `windows/runner/main.cpp` (the `Win32Window::Size` line and `window.Create` call, ~line 30)
- Modify: `windows/runner/win32_window.cpp` (`Win32Window::MessageHandler` switch)

- [ ] **Step 1: Set title and default size in `main.cpp`**

Find (exact lines may shift slightly with the Flutter template version):

```cpp
  Win32Window::Point origin(10, 10);
  Win32Window::Size size(1280, 720);
  if (!window.Create(L"enigma_signal_meter", origin, size)) {
```

Replace with:

```cpp
  Win32Window::Point origin(10, 10);
  // Phone-like portrait window (9:16) — the app's layouts are portrait-first.
  Win32Window::Size size(450, 800);
  if (!window.Create(L"Enigma Signal Meter", origin, size)) {
```

- [ ] **Step 2: Enforce minimum size in `win32_window.cpp`**

In `Win32Window::MessageHandler`, add a `WM_GETMINMAXINFO` case to the `switch (message)` block, directly above the existing `case WM_SIZE:`:

```cpp
    case WM_GETMINMAXINFO: {
      // Phone-like minimum (360x640 logical px), scaled for monitor DPI.
      UINT dpi = FlutterDesktopGetDpiForHWND(hwnd);
      double scale_factor = dpi / 96.0;
      MINMAXINFO* info = reinterpret_cast<MINMAXINFO*>(lparam);
      info->ptMinTrackSize.x = Scale(360, scale_factor);
      info->ptMinTrackSize.y = Scale(640, scale_factor);
      return 0;
    }
```

Notes: the template already defines the `Scale(int, double)` helper in an anonymous namespace at the top of this file and already includes `flutter_windows.h` (which declares `FlutterDesktopGetDpiForHWND`). If either is absent in this template version, the helper is `static_cast<int>(source * scale_factor)` and the include is `#include <flutter_windows.h>`.

- [ ] **Step 3: Verify**

Run: `flutter run -d windows`
Expected: window opens portrait (~450×800) titled "Enigma Signal Meter". Drag-resize smaller — it must stop shrinking at 360×640 logical px. Quit.

- [ ] **Step 4: Commit**

```powershell
git add windows/runner/main.cpp windows/runner/win32_window.cpp
git commit -m "feat(windows): portrait default window with phone-like minimum size"
```

---

### Task 3: Windows app icon

**Files:**
- Modify: `pubspec.yaml` (the `flutter_launcher_icons:` section)
- Regenerated: `windows/runner/resources/app_icon.ico`

- [ ] **Step 1: Add Windows icon config**

In `pubspec.yaml`, the section currently reads:

```yaml
flutter_launcher_icons:
  image_path_android: "assets/icons/esm_icon_1024_1024_Android.png"
  image_path_ios: "assets/icons/esm_icon_1024_1024_iOS.png"
  android: true # can specify file name here e.g. "ic_launcher"
  ios: true # can specify file name here e.g. "My-Launcher-Icon"
  adaptive_icon_background: "#64ffda" # only available for Android 8.0 devices and above
  adaptive_icon_foreground: "assets/icons/esm_icon_432_432_adaptive.png" # only available for Android 8.0 devices and above
```

Append this nested block at the same indent level as `android:`:

```yaml
  windows:
    generate: true
    image_path: "assets/icons/esm_icon_1024_1024_iOS.png"
    icon_size: 256
```

- [ ] **Step 2: Generate**

Run: `dart run flutter_launcher_icons`
Expected: output includes a Windows section ending in a success tick; `windows/runner/resources/app_icon.ico` has a new timestamp.

Then run `git status` — the tool regenerates Android/iOS icons too. If any file under `android/` or `ios/` shows as modified with an actual diff, restore those with `git checkout -- android ios` (the source images are unchanged, so regenerated mobile icons must be content-identical; a diff means tool-version noise we don't want in this commit). Keep only the new `.ico` and the `pubspec.yaml` change.

- [ ] **Step 3: Verify**

Run: `flutter run -d windows`
Expected: the satellite-dish app icon appears in the title bar and taskbar. Quit.

- [ ] **Step 4: Commit**

```powershell
git add pubspec.yaml windows/runner/resources/app_icon.ico
git commit -m "feat(windows): generate Windows app icon"
```

---

### Task 4: Add-profile button on Windows

**Files:**
- Modify: `lib/src/ui/home/home_view.dart` (two `Platform.isAndroid` conditions, ~lines 103 and 116)

**Background:** the add-profile (+) FAB is gated `Platform.isAndroid`, and the iOS alternative (the "ADD PROFILE" text button in `profiles_view.dart`) is gated `Platform.isIOS`. On Windows neither renders, so a fresh install cannot create a profile (found during Task 1 verification). Fix: Windows joins the Android branch — the Material FAB suits the app's Material theme. `profiles_view.dart` stays iOS-only.

No TDD for this task: both conditions read `dart:io` `Platform` directly, which cannot be faked in widget tests without a refactor that is out of scope. Covered by manual verification.

- [ ] **Step 1: Widen the FAB condition**

In `lib/src/ui/home/home_view.dart` find:

```dart
          floatingActionButton: Platform.isAndroid
              ? Showcase(
```

replace with:

```dart
          floatingActionButton: Platform.isAndroid || Platform.isWindows
              ? Showcase(
```

- [ ] **Step 2: Widen the showcase-target condition**

Same file, find:

```dart
          if (Platform.isAndroid) {
            ShowCaseWidget.of(context).startShowCase([_fabShowcaseKey]);
          } else {
```

replace with:

```dart
          if (Platform.isAndroid || Platform.isWindows) {
            ShowCaseWidget.of(context).startShowCase([_fabShowcaseKey]);
          } else {
```

- [ ] **Step 3: Analyze and run full test suite**

Run: `flutter analyze && flutter test`
Expected: no new analyzer issues beyond the 56-item baseline, and all tests pass.

- [ ] **Step 4: Manual verify on Windows**

Build and launch the debug exe. Expected: with no connection, the (+) FAB is visible bottom-right on the home screen; clicking it opens the profile editor; on a first launch the showcase bubble points at the FAB.

- [ ] **Step 5: Commit**

```powershell
git add lib/src/ui/home/home_view.dart
git commit -m "fix(windows): show add-profile FAB on Windows"
```

---
### Task 5: VlcLauncher — stream playback on Windows

**Files:**
- Create: `lib/src/utils/vlc_launcher.dart`
- Create: `test/unit/utils/vlc_launcher_test.dart`
- Modify: `lib/src/ui/more/more_viewmodel.dart:144-160` (the platform branch) and imports
- Modify: `pubspec.yaml` (+ `win32_registry`)

- [ ] **Step 1: Add dependency**

Run: `flutter pub add win32_registry`
Expected: resolves and lands in `dependencies:`.

- [ ] **Step 2: Write the failing test**

Create `test/unit/utils/vlc_launcher_test.dart`:

```dart
import 'package:enigma_signal_meter/src/utils/vlc_launcher.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('findVlcPath', () {
    test('returns vlc.exe from registry InstallDir when present', () {
      final path = VlcLauncher.findVlcPath(
        readInstallDir: (keyPath) =>
            keyPath == r'SOFTWARE\VideoLAN\VLC' ? r'D:\Apps\VLC' : null,
        fileExists: (path) => path == r'D:\Apps\VLC\vlc.exe',
      );
      expect(path, r'D:\Apps\VLC\vlc.exe');
    });

    test('falls back to the WOW6432Node registry key', () {
      final path = VlcLauncher.findVlcPath(
        readInstallDir: (keyPath) =>
            keyPath == r'SOFTWARE\WOW6432Node\VideoLAN\VLC'
                ? r'D:\Apps\VLC32'
                : null,
        fileExists: (path) => path == r'D:\Apps\VLC32\vlc.exe',
      );
      expect(path, r'D:\Apps\VLC32\vlc.exe');
    });

    test('falls back to standard install paths when registry is empty', () {
      final path = VlcLauncher.findVlcPath(
        readInstallDir: (_) => null,
        fileExists: (path) =>
            path == r'C:\Program Files\VideoLAN\VLC\vlc.exe',
      );
      expect(path, r'C:\Program Files\VideoLAN\VLC\vlc.exe');
    });

    test('ignores a registry dir whose vlc.exe does not exist', () {
      final path = VlcLauncher.findVlcPath(
        readInstallDir: (keyPath) =>
            keyPath == r'SOFTWARE\VideoLAN\VLC' ? r'D:\Gone' : null,
        fileExists: (path) =>
            path == r'C:\Program Files\VideoLAN\VLC\vlc.exe',
      );
      expect(path, r'C:\Program Files\VideoLAN\VLC\vlc.exe');
    });

    test('returns null when VLC is nowhere to be found', () {
      final path = VlcLauncher.findVlcPath(
        readInstallDir: (_) => null,
        fileExists: (_) => false,
      );
      expect(path, isNull);
    });
  });
}
```

- [ ] **Step 3: Run test to verify it fails**

Run: `flutter test test/unit/utils/vlc_launcher_test.dart`
Expected: FAIL — compilation error, `vlc_launcher.dart` does not exist.

- [ ] **Step 4: Implement `VlcLauncher`**

Create `lib/src/utils/vlc_launcher.dart`:

```dart
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:win32_registry/win32_registry.dart';

/// Locates and launches VLC for stream playback on Windows, falling back to
/// the default URL handler when VLC is not installed.
class VlcLauncher {
  static final Logger _log = Logger('VlcLauncher');

  static const List<String> _registryKeyPaths = [
    r'SOFTWARE\VideoLAN\VLC',
    r'SOFTWARE\WOW6432Node\VideoLAN\VLC',
  ];

  static const List<String> _probePaths = [
    r'C:\Program Files\VideoLAN\VLC\vlc.exe',
    r'C:\Program Files (x86)\VideoLAN\VLC\vlc.exe',
  ];

  /// Returns the full path to vlc.exe, or null if VLC is not installed.
  ///
  /// [readInstallDir] and [fileExists] exist for test injection only.
  static String? findVlcPath({
    String? Function(String registryKeyPath) readInstallDir =
        _readInstallDirFromRegistry,
    bool Function(String path) fileExists = _fileExists,
  }) {
    for (final keyPath in _registryKeyPaths) {
      final installDir = readInstallDir(keyPath);
      if (installDir != null) {
        final vlcPath = '$installDir\\vlc.exe';
        if (fileExists(vlcPath)) {
          return vlcPath;
        }
      }
    }
    for (final path in _probePaths) {
      if (fileExists(path)) {
        return path;
      }
    }
    return null;
  }

  /// Plays [streamUri] in VLC if installed, otherwise hands the URI to the
  /// default handler. Failures are logged, never surfaced.
  static Future<void> playStream(String streamUri) async {
    try {
      final vlcPath = findVlcPath();
      if (vlcPath != null) {
        await Process.start(
          vlcPath,
          [streamUri],
          mode: ProcessStartMode.detached,
        );
        return;
      }
      await launchUrl(Uri.parse(streamUri));
    } catch (e) {
      _log.warning('Failed to launch stream: $e');
    }
  }

  static String? _readInstallDirFromRegistry(String keyPath) {
    try {
      final key = LOCAL_MACHINE.open(keyPath);
      try {
        return key.getString('InstallDir');
      } finally {
        key.close();
      }
    } catch (_) {
      // Key absent or access denied — treat as not installed.
      return null;
    }
  }

  static bool _fileExists(String path) => File(path).existsSync();
}
```

API-drift note: in `win32_registry` 2.x the read call is `LOCAL_MACHINE.open(path)` / `key.getString(name)`. If the resolved version is 1.x, the equivalents are `Registry.openPath(RegistryHive.localMachine, path: path)` / `key.getValueAsString(name)`.

- [ ] **Step 5: Run test to verify it passes**

Run: `flutter test test/unit/utils/vlc_launcher_test.dart`
Expected: PASS (5 tests).

- [ ] **Step 6: Wire into the More menu viewmodel**

In `lib/src/ui/more/more_viewmodel.dart`, add the import (alphabetical, after the existing `stream_manager.dart` import):

```dart
import 'package:enigma_signal_meter/src/utils/vlc_launcher.dart';
```

Then replace the platform branch:

```dart
    final streamUri = parameters.streamUri!;
    if (Platform.isAndroid) {
      var intent = AndroidIntent(
        action: 'action_view',
        data: streamUri,
        type: 'video/*',
      );
      await intent.launch();
    } else {
```

with:

```dart
    final streamUri = parameters.streamUri!;
    if (Platform.isAndroid) {
      var intent = AndroidIntent(
        action: 'action_view',
        data: streamUri,
        type: 'video/*',
      );
      await intent.launch();
    } else if (Platform.isWindows) {
      await VlcLauncher.playStream(streamUri);
    } else {
```

(The iOS `else` block below stays untouched.)

- [ ] **Step 7: Analyze and run full test suite**

Run: `flutter analyze && flutter test`
Expected: no new analyzer issues beyond the 56-item baseline, and all tests pass.

- [ ] **Step 8: Manual verify on Windows**

Run: `flutter run -d windows`, connect to a receiver with streaming enabled, choose the Stream menu item. Expected with VLC installed: VLC opens and plays the stream. (The no-VLC fallback path is covered by the unit tests; no need to uninstall VLC to verify it manually.) Quit.

- [ ] **Step 9: Commit**

```powershell
git add pubspec.yaml pubspec.lock lib/src/utils/vlc_launcher.dart test/unit/utils/vlc_launcher_test.dart lib/src/ui/more/more_viewmodel.dart
git commit -m "feat(windows): play streams in VLC with default-handler fallback"
```

---

### Task 6: Release build, smoke checklist, docs

**Files:**
- Modify: `CHANGES.TXT`
- Modify: `README.md:3`

- [ ] **Step 1: Full verification**

Run: `flutter analyze && flutter test && flutter build windows --release`
Expected: no issues, all tests pass, build succeeds producing `build\windows\x64\runner\Release\enigma_signal_meter.exe`.

- [ ] **Step 2: Run the release exe**

Run: `& "build\windows\x64\runner\Release\enigma_signal_meter.exe"`
Expected: app starts standalone (this catches release-only issues like missing assets or tree-shaken icons).

- [ ] **Step 3: Manual smoke checklist (release exe, real receiver)**

Work through, in the running app:
- [ ] Connect to a receiver profile
- [ ] Signal monitoring updates (circular indicators + chart)
- [ ] Full-screen chart opens and renders
- [ ] TTS announcement is audible and at a sane rate (non-iOS rate 1.0)
- [ ] Screenshot: fetch, save (lands in Pictures), share (Windows share dialog)
- [ ] Stream menu item launches VLC (or default handler without VLC)
- [ ] Display stays awake during monitoring (wakelock) — check no screen blanking for a few minutes
- [ ] Resize window down to the 360×640 minimum — no overflow stripes on main screens

Record any failures; UI overflows at minimum size or a broken TTS rate are fix-forward items to raise before closing the task.

- [ ] **Step 4: Update CHANGES.TXT**

Append to the existing bullet list in `CHANGES.TXT`:

```text
- Added Windows desktop support: portrait window, screenshots save to Pictures, streams play in VLC
```

- [ ] **Step 5: Update README.md**

After line 3 (`Use your phone or tablet to align your satellite dish...`), append to that sentence's paragraph:

```markdown
Also runs as a Windows desktop app.
```

- [ ] **Step 6: Commit**

```powershell
git add CHANGES.TXT README.md
git commit -m "docs: note Windows desktop support"
```

Note: `CHANGES.TXT` has pre-existing uncommitted edits from the 1.1.2 release-notes work — this commit will include them. If that is undesirable, tell the user and ask whether to commit them together or stage the new bullet separately (e.g. via `git add -p CHANGES.TXT`).

---

## Out of scope (per spec — do not implement)

MSIX/Microsoft Store packaging, installer, code signing, window size/position persistence, keyboard shortcuts, wide-screen layouts, macOS/Linux, CI for Windows builds.
