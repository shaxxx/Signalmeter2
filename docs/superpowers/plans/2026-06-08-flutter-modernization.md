# Flutter Modernization Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Bring `enigma_signal_meter` from pre-null-safety Flutter (Dart 2.7) up to the installed toolchain (Flutter 3.41 / Dart 3.11) with all plugins on maintained versions, building and running on Android, iOS kept buildable.

**Architecture:** Single sequenced branch (`flutter-modernization`). Because Dart 3 forbids mixed-mode null safety, the codebase will not compile until null safety + plugin-API swaps are complete — so this is a "big-bang" migration validated by `flutter analyze` rather than incremental runtime checks. The plan is a **hybrid**: deterministic tasks give exact file content (pubspec, gradle, manifest, MainActivity, and every known plugin call-site); the bulk null-safety conversion is an **analyzer-gated process** (run analyzer → apply standard null-safety fixes → repeat until clean) because the exact `?`/`!`/`required`/`late` edits per file depend on analyzer output and cannot be pre-scripted. Redux architecture is preserved. i18n stays on `intl_translation` (bumped to null-safe); full `gen-l10n` migration is an explicit out-of-scope follow-up.

**Tech Stack:** Flutter 3.41 / Dart 3.11, Redux (`flutter_redux`), `intl`/`intl_translation`, Android Gradle Plugin 8 + Gradle 8 + Kotlin, `enigma_web 2.0.0` (local path dep during migration).

---

## File Structure

Files created or substantially rewritten by this plan:

- `../flutter_flip_view/pubspec.yaml` + `../flutter_flip_view/lib/flutter_flip_view.dart` — null-safety migrate the fork (no null-safe release exists on pub.dev) (modify, separate repo)
- `pubspec.yaml` — dependency versions, SDK bump, path deps for enigma_web + flutter_flip_view (modify)
- `analysis_options.yaml` — pedantic → flutter_lints (modify)
- `android/build.gradle`, `android/settings.gradle`, `android/gradle.properties` — AGP 8 / Gradle 8 / plugins DSL, drop jcenter (rewrite)
- `android/gradle/wrapper/gradle-wrapper.properties` — Gradle 8 distribution (modify)
- `android/app/build.gradle` — plugins DSL, namespace, compileSdk 34, JDK 17 (rewrite)
- `android/app/src/main/AndroidManifest.xml` — embedding v2 (rewrite)
- `android/app/src/main/kotlin/com/krkadoni/app/signalmeter/MainActivity.kt` — Kotlin embedding-v2 activity (create)
- `android/app/src/main/java/.../MainActivity.java` — delete
- `lib/src/utils/snackbar_handler.dart` — flushbar → another_flushbar, FlatButton → TextButton (modify)
- `lib/src/redux/monitor/signal_monitor_middleware.dart` — wakelock → wakelock_plus (modify)
- `lib/src/utils/tts_utils.dart` — flutter_tts 4.x (modify)
- `lib/src/ui/common/hyperlink.dart`, `lib/src/ui/more/more_viewmodel.dart`, `lib/src/ui/settings/settings_viewmodel.dart` — url_launcher 6.x (modify)
- `lib/src/ui/screenshot/screenshot_view.dart` — share_plus, gal, permission_handler 12.x, auto_orientation replacement (rewrite)
- `lib/src/ui/home/home_view.dart`, `lib/src/ui/signal/signal_chart_full_screen_view.dart` — auto_orientation replacement (modify)
- `lib/src/ui/home/home_view.dart`, `lib/src/ui/profiles/profiles_view.dart` — showcaseview 4.x (modify)
- `lib/src/ui/signal/signal_chart_view.dart` — fl_chart 1.x rewrite (rewrite)
- `lib/src/ui/about/about_view.dart` — package_info_plus (modify)
- All `lib/**/*.dart` — null-safety annotations (analyzer-gated, bulk)
- `test/unit/redux/*_test.dart`, `test/widget/*_test.dart` — safety-net tests (create)

---

## Phase 0 — Prep & Pin

### Task 0.1: Confirm branch and baseline

**Files:** none (verification only)

- [ ] **Step 1: Confirm on the migration branch**

Run: `git branch --show-current`
Expected: `flutter-modernization`

- [ ] **Step 2: Record the starting toolchain**

Run: `flutter --version`
Expected: Flutter 3.41.x / Dart 3.11.x (record exact in commit message later).

- [ ] **Step 3: Confirm the local enigma_web path exists and is null-safe**

Run: `cat ../EnigmaWeb.Dart/pubspec.yaml | grep -E "version|sdk"`
Expected: `version: 2.0.0`, `sdk: ">=3.0.0 <4.0.0"`.

### Task 0.2: Bump SDK constraint and add path dependency

**Files:**
- Modify: `pubspec.yaml:17-18` (environment), `pubspec.yaml:30` (enigma_web)

- [ ] **Step 1: Raise the Dart SDK constraint**

Replace:
```yaml
environment:
  sdk: ">=2.7.0 <3.0.0"
```
with:
```yaml
environment:
  sdk: ">=3.0.0 <4.0.0"
```

- [ ] **Step 2: Point enigma_web at the local null-safe package**

Replace `enigma_web: ^1.0.5` with:
```yaml
  enigma_web:
    path: ../EnigmaWeb.Dart
```

- [ ] **Step 3: Commit**

```bash
git add pubspec.yaml
git commit -m "chore: bump Dart SDK to 3.0 and point enigma_web at local path dep"
```

### Task 0.3: Null-safety migrate the `flutter_flip_view` fork

`flutter_flip_view 1.0.3` has **no null-safe release on pub.dev**, so on Dart 3 it blocks `pub get` entirely. The fork at `C:\Users\isako\source\repos\flutter_flip_view` (`shaxxx/flutter_flip_view`, `master`) is a single Dart file and migrates trivially. This must be done **before** Phase 1's `flutter pub get`.

**Files (in the fork repo `../flutter_flip_view`):**
- Modify: `pubspec.yaml`, `lib/flutter_flip_view.dart`

- [ ] **Step 1: Bump the fork's SDK constraint**

In `../flutter_flip_view/pubspec.yaml` change:
```yaml
environment:
  sdk: ">=2.0.0-dev.68.0 <3.0.0"
```
to:
```yaml
environment:
  sdk: ">=3.0.0 <4.0.0"
  flutter: ">=1.17.0"
```
(Optionally bump `version: 1.0.3` → `2.0.0` and drop the deprecated `author:` field.)

- [ ] **Step 2: Migrate `lib/flutter_flip_view.dart` to null safety**

Apply these exact changes:
- Constructor: `Key key,` → `Key? key,`; `@required this.front,` → `required this.front,`; `@required this.back,` → `required this.back,`; `@required this.animationController,` → `required this.animationController,`.
- Defaulted named params: `AxisDirection goBackDirection,` → `AxisDirection? goBackDirection,` and `AxisDirection goFrontDirection,` → `AxisDirection? goFrontDirection,` (the `?? AxisDirection.left` initializers already handle null).
- Fields: `Animation<double> _animation;` → `late Animation<double> _animation;`; `AnimationStatus _lastStatus;` → `AnimationStatus? _lastStatus;`.
- `AnimatedBuilder` builder signature: `builder: (BuildContext context, Widget child) {` → `builder: (BuildContext context, Widget? child) {`.

Resulting constructor for reference:
```dart
const FlipView({
  Key? key,
  required this.front,
  required this.back,
  required this.animationController,
  AxisDirection? goBackDirection,
  AxisDirection? goFrontDirection,
})  : goBackDirection = goBackDirection ?? AxisDirection.left,
      goFrontDirection = goFrontDirection ?? AxisDirection.left,
      super(key: key);
```

- [ ] **Step 3: Verify the fork analyzes cleanly**

Run: `cd ../flutter_flip_view && dart pub get && flutter analyze`
Expected: `No issues found!`

- [ ] **Step 4: Commit the fork**

```bash
cd ../flutter_flip_view
git add pubspec.yaml lib/flutter_flip_view.dart
git commit -m "feat: migrate to null safety (Dart 3)"
cd ../Signalmeter2
```
(The main app already references it via the `path:` dep added in Task 1.1. Publishing the fork or switching to a git/hosted ref is a later, optional step.)

---

## Phase 1 — Dependency Resolution

### Task 1.1: Rewrite the dependency block

**Files:**
- Modify: `pubspec.yaml:20-59`

- [ ] **Step 1: Replace the `dependencies` block**

Use these constraints (drop the `permission_handler` git fork; the missing intent params are upstreamed). If `flutter pub get` fails to resolve a line, relax it to the next compatible major and note it.

```yaml
dependencies:
  flutter:
    sdk: flutter

  flutter_localizations:
    sdk: flutter

  enigma_web:
    path: ../EnigmaWeb.Dart
  flutter_flip_view:
    path: ../flutter_flip_view
  flutter_redux: ^0.10.0
  flutter_redux_navigation: ^0.8.0
  percent_indicator: ^4.2.3
  xml: ^6.5.0
  fl_chart: ^1.0.0
  wakelock_plus: ^1.2.8
  another_flushbar: ^1.12.30
  url_launcher: ^6.3.1
  package_info_plus: ^8.1.1
  auto_size_text: ^3.0.0
  flutter_tts: ^4.2.0
  shared_preferences: ^2.3.3
  photo_view: ^0.15.0
  share_plus: ^10.1.2
  gal: ^2.3.0
  showcaseview: ^4.0.1
  android_intent_plus: ^5.2.0
  permission_handler: ^12.0.0
  intl: ^0.20.2
```

- [ ] **Step 2: Replace the `dev_dependencies` block**

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  intl_translation: ^0.20.1
  flutter_launcher_icons: ^0.14.1
  flutter_lints: ^5.0.0
```

- [ ] **Step 3: Rename the launcher-icons config key**

The `flutter_icons:` top-level key is renamed to `flutter_launcher_icons:` in v0.14. Rename the existing `flutter_icons:` block key to `flutter_launcher_icons:` (keep all sub-keys identical).

- [ ] **Step 4: Resolve dependencies**

Run: `flutter pub get`
Expected: resolves successfully. If a constraint conflicts, relax that single line and re-run; record the final version. Note any `minSdk` requirement printed by plugins (permission_handler/share_plus typically require Android `minSdk 21`+, often `23`).

- [ ] **Step 5: Commit**

```bash
git add pubspec.yaml pubspec.lock
git commit -m "chore: update all plugins to maintained null-safe versions"
```

> **Note:** After this commit the project will NOT analyze cleanly — old call sites and pre-null-safety code remain. That is expected; Phase 2 fixes it. Do not attempt to build until Phase 3.

---

## Phase 2 — Null-Safety + Plugin-API Migration (compile-green)

This phase converts all Dart to null safety AND updates the plugin call sites, because the new (null-safe) plugin versions and the migrated code must compile together. Work bottom-up so types stabilize before their consumers. The gate for the whole phase is `flutter analyze` clean.

### The null-safety fix playbook (apply throughout this phase)

When the analyzer reports an error, apply the standard fix — do not suppress:
- **Uninitialized non-nullable field** → make it nullable (`Foo? x;`), `late` if always set before use, or give an initializer.
- **`@required` annotation** → replace with the `required` keyword on the parameter; drop `import 'package:meta/meta.dart'` if now unused.
- **Nullable value used where non-null expected** → add a real null check/guard; use `!` only when an invariant guarantees non-null (never to silence the analyzer blindly).
- **`?.` chains returning nullable** → provide `?? <default>` or guard.
- **Removed Flutter APIs** → `FlatButton`→`TextButton`, `RaisedButton`→`ElevatedButton`, `OutlineButton`→`OutlinedButton`; `Color.withOpacity(x)`→`Color.withValues(alpha: x)` (Flutter 3.27+); `value`/`onChanged` deprecations as reported.
- After each module compiles, run that module's analyzer scope before moving on.

### Task 2.1: Migrate `lib/src/model/` and `lib/src/constants.dart`

**Files:**
- Modify: all files under `lib/src/model/`, `lib/src/constants.dart`

- [ ] **Step 1: Run the analyzer scoped to the model layer**

Run: `flutter analyze lib/src/model lib/src/constants.dart`
Expected: a list of null-safety errors (uninitialized fields, `@required`, etc.).

- [ ] **Step 2: Apply the playbook fixes to every reported error**

Edit each reported file per the playbook above. Model classes typically need: constructor params `required` or nullable, fields nullable or `late`, `==`/`hashCode` null-aware.

- [ ] **Step 3: Re-run until clean**

Run: `flutter analyze lib/src/model lib/src/constants.dart`
Expected: `No issues found!` for these paths (errors elsewhere are fine for now).

- [ ] **Step 4: Commit**

```bash
git add lib/src/model lib/src/constants.dart
git commit -m "refactor: null-safety migrate model layer"
```

### Task 2.2: Migrate `lib/src/redux/` (reducers, state, middleware, events)

**Files:**
- Modify: all files under `lib/src/redux/`
- Special: `lib/src/redux/monitor/signal_monitor_middleware.dart` (wakelock swap)

- [ ] **Step 1: Swap wakelock → wakelock_plus**

In `lib/src/redux/monitor/signal_monitor_middleware.dart`, change the import:
```dart
import 'package:wakelock_plus/wakelock_plus.dart';
```
and the two call sites (lines ~86, ~92):
```dart
unawaited(WakelockPlus.enable());
```
```dart
unawaited(WakelockPlus.disable());
```

- [ ] **Step 2: Run the analyzer scoped to redux**

Run: `flutter analyze lib/src/redux`
Expected: null-safety errors across reducers/state/middleware.

- [ ] **Step 3: Apply playbook fixes**

State classes: nullable/`late` fields, `required` constructor params. Reducers: ensure exhaustive non-null returns. Middleware: guard nullable store/action fields.

- [ ] **Step 4: Re-run until clean**

Run: `flutter analyze lib/src/redux`
Expected: `No issues found!` for `lib/src/redux`.

- [ ] **Step 5: Commit**

```bash
git add lib/src/redux
git commit -m "refactor: null-safety migrate redux layer; wakelock_plus swap"
```

### Task 2.3: Migrate `lib/src/utils/` + TTS and snackbar plugin swaps

**Files:**
- Modify: all files under `lib/src/utils/`
- Rewrite: `lib/src/utils/snackbar_handler.dart` (flushbar → another_flushbar)
- Modify: `lib/src/utils/tts_utils.dart` (flutter_tts 4.x)

- [ ] **Step 1: Migrate snackbar_handler.dart to another_flushbar**

Change the import:
```dart
import 'package:another_flushbar/flushbar.dart';
```
Replace both `FlatButton(...)` usages (removed in Flutter 3) with `TextButton`. The error-snackbar `mainButton`:
```dart
mainButton: detailsMessage == null
    ? null
    : TextButton(
        style: TextButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          MessageProvider.of(context).details.toUpperCase(),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  MessageProvider.of(context).titleError.toUpperCase(),
                ),
                content: Text(detailsMessage),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      MessageProvider.of(context).close.toUpperCase(),
                    ),
                  )
                ],
              );
            });
        }),
```
Make the `snackBars` list and `duration` handling null-safe: `s.duration` is nullable in another_flushbar — guard with `(s.duration ?? const Duration(seconds: 3)).inSeconds`.

- [ ] **Step 2: Migrate tts_utils.dart to flutter_tts 4.x**

The core API is unchanged (`speak`, `setLanguage`, `awaitSpeakCompletion`, `stop`). Apply null-safety: `FlutterTts? _flutterTts` stays non-null via constructor; ensure `await` on all calls. Verify `_flutterTts` field and the singleton `_instance` are null-safe (`static TtsUtils? _instance;`).

- [ ] **Step 3: Run analyzer scoped to utils**

Run: `flutter analyze lib/src/utils`
Expected: errors; apply playbook + the swaps above.

- [ ] **Step 4: Re-run until clean**

Run: `flutter analyze lib/src/utils`
Expected: `No issues found!` for `lib/src/utils`.

- [ ] **Step 5: Commit**

```bash
git add lib/src/utils
git commit -m "refactor: null-safety migrate utils; another_flushbar + flutter_tts 4.x"
```

### Task 2.4: Migrate i18n layer (null-safe intl)

**Files:**
- Modify: `lib/src/i18n/*.dart`, `lib/src/message_provider.dart`

> Note: `lib/src/i18n/**` is excluded from analysis (see `analysis_options.yaml`). Keep the existing `intl_translation` toolchain; only fix null-safety in `message_provider.dart` and any non-generated i18n helper.

- [ ] **Step 1: Run analyzer on message_provider.dart**

Run: `flutter analyze lib/src/message_provider.dart`
Expected: errors on nullable `Localizations.of` (returns `MessageProvider?`).

- [ ] **Step 2: Fix the nullable Localizations lookup**

```dart
static Messages of(BuildContext context) {
  return Localizations.of<MessageProvider>(context, MessageProvider)!.messages;
}
```
Apply playbook to the delegate's `load`/`getTranslatedLocale`/`getWebLanguageCode` as reported.

- [ ] **Step 3: Re-run until clean**

Run: `flutter analyze lib/src/message_provider.dart`
Expected: `No issues found!`.

- [ ] **Step 4: Commit**

```bash
git add lib/src/message_provider.dart lib/src/i18n
git commit -m "refactor: null-safety migrate i18n provider"
```

### Task 2.5: Migrate `lib/src/ui/` + remaining plugin swaps

**Files:**
- Modify: all files under `lib/src/ui/` and `lib/main.dart`
- Specific rewrites listed below.

- [ ] **Step 1: url_launcher 6.x — hyperlink.dart, more_viewmodel.dart, settings_viewmodel.dart**

Replace `launch(url)` with `launchUrl`. In `lib/src/ui/common/hyperlink.dart:21`:
```dart
await launchUrl(Uri.parse(url));
```
In `lib/src/ui/more/more_viewmodel.dart:158`:
```dart
await launchUrl(Uri.parse(iOSUri));
```
In `lib/src/ui/settings/settings_viewmodel.dart:26`:
```dart
onSupport: (url) => launchUrl(Uri.parse(url)),
```
Add/confirm `import 'package:url_launcher/url_launcher.dart';` in each.

- [ ] **Step 2: android_intent_plus — more_viewmodel.dart**

In `lib/src/ui/more/more_viewmodel.dart`, change the import to:
```dart
import 'package:android_intent_plus/android_intent.dart';
```
`AndroidIntent(...)` constructor and `.launch()` are unchanged.

- [ ] **Step 3: package_info_plus — about_view.dart**

In `lib/src/ui/about/about_view.dart`, change import to:
```dart
import 'package:package_info_plus/package_info_plus.dart';
```
`PackageInfo.fromPlatform()` is unchanged. Make `_packageInfo` nullable: `PackageInfo? _packageInfo;` and null-guard its reads.

- [ ] **Step 4: Replace auto_orientation with SystemChrome**

`auto_orientation` is unmaintained. Replace its uses with `SystemChrome.setPreferredOrientations`. Add `import 'package:flutter/services.dart';` where needed.
- `home_view.dart:50` `AutoOrientation.portraitAutoMode();` →
  ```dart
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  ```
- `signal_chart_full_screen_view.dart:29` `AutoOrientation.landscapeAutoMode();` →
  ```dart
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  ```
- `signal_chart_full_screen_view.dart:40` and `screenshot_view.dart:37` `portraitAutoMode()` → the portrait block above.
- `screenshot_view.dart:32` `AutoOrientation.fullAutoMode();` →
  ```dart
  SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  ```
Remove all `import 'package:auto_orientation/auto_orientation.dart';`.

- [ ] **Step 5: Rewrite screenshot_view.dart (share_plus + gal + permission_handler 12.x)**

Replace the imports:
```dart
import 'package:share_plus/share_plus.dart';
import 'package:gal/gal.dart';
import 'package:permission_handler/permission_handler.dart';
```
(remove `wc_flutter_share`, `image_gallery_saver`, `auto_orientation`).

Share button `onPressed` — write bytes to an `XFile` and share:
```dart
onPressed: () async {
  final bytes = viewModel.response?.screenshot;
  if (bytes != null) {
    await Share.shareXFiles(
      [
        XFile.fromData(
          Uint8List.fromList(bytes),
          name: '$fileName.jpg',
          mimeType: 'image/jpeg',
        )
      ],
      subject: MessageProvider.of(context).share,
    );
  }
},
```

Save button `onPressed` — use `gal`:
```dart
onPressed: () async {
  final bytes = viewModel.response?.screenshot;
  if (bytes == null) return;
  try {
    if (!await Gal.hasAccess()) {
      await Gal.requestAccess();
    }
    await Gal.putImageBytes(Uint8List.fromList(bytes), name: fileName);
    StoreProvider.of<AppState>(context)
        .dispatch(ScreenshotSavedInfoMessageEvent());
  } on GalException catch (_) {
    // permission denied / save failed — leave UI unchanged
  }
},
```
Delete the old `_checkPermissions`/`_checkPermissionsIos`/`_checkPermissionsAndroid` methods (the old `PermissionHandler()`/`PermissionGroup` API is gone; `gal` handles gallery access). If other screens still need permission_handler 12.x, the new API is `await Permission.photos.request()` returning `PermissionStatus`.

- [ ] **Step 6: showcaseview 4.x — home_view.dart, profiles_view.dart**

Consolidate imports to:
```dart
import 'package:showcaseview/showcaseview.dart';
```
(remove `showcase.dart` / `showcase_widget.dart`). In `home_view.dart` the `ShowCaseWidget(builder: (context) {...})` becomes:
```dart
ShowCaseWidget(
  builder: (context) => /* existing child */,
)
```
(In showcaseview 4.x `builder` is a `WidgetBuilder` — `builder: (context) => child`. If the installed version exposes `Builder`, use `builder: Builder(builder: (context) => child)`; pick whichever the analyzer accepts.) `ShowCaseWidget.of(context).startShowCase([key])` is unchanged. `Showcase(key:, title:, description:, child:)` is unchanged.

- [ ] **Step 7: Rewrite signal_chart_view.dart for fl_chart 1.x**

Replace `_getChartData` and the `titlesData`/`gridData` config. Key changes: `colors:`→`gradient:`; `SideTitles` wrapped in `AxisTitles`; `getTitles`→`getTitlesWidget` (returns a `Widget`); `withOpacity`→`withValues(alpha:)`. Replace the `LineChart(...)` `titlesData` and the `_getChartData`/`_getTitle` members:

```dart
titlesData: FlTitlesData(
  show: true,
  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  bottomTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  leftTitles: AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: 30,
      interval: viewModel.useDb ? 1 : 10,
      getTitlesWidget: (value, meta) => _getTitleWidget(value, viewModel),
    ),
  ),
),
```
```dart
Widget _getTitleWidget(double value, SignalChartViewModel viewModel) {
  const style = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
  String text = '';
  if (viewModel.useDb) {
    if (value == 1.0) text = '1 db';
    else if (value == 8.0) text = '8 db';
    else if (value == 16.0) text = '16 dB';
  } else {
    switch (value.toInt()) {
      case 10: text = '10%'; break;
      case 50: text = '50%'; break;
      case 100: text = '100%'; break;
    }
  }
  return Padding(
    padding: const EdgeInsets.only(right: 12),
    child: Text(text, style: style),
  );
}

LineChartBarData _getChartData(SignalChartViewModel viewModel) {
  final spots = <FlSpot>[];
  viewModel.chartPoints.forEach((x, y) => spots.add(FlSpot(x, y)));
  return LineChartBarData(
    spots: spots,
    isCurved: true,
    gradient: LinearGradient(colors: gradientColors),
    barWidth: 3,
    isStrokeCapRound: true,
    dotData: const FlDotData(show: false),
    belowBarData: BarAreaData(
      show: true,
      gradient: LinearGradient(
        colors: gradientColors
            .map((c) => c.withValues(alpha: 0.3))
            .toList(),
      ),
    ),
  );
}
```
Remove the old `_getTitle` method and the `getDrawingVerticalLine`/`getDrawingHorizontalLine` `FlLine` colors if the analyzer flags `withOpacity`. If `swapAnimationDuration` is flagged, rename to `duration:`.

- [ ] **Step 8: Run the analyzer across the whole project**

Run: `flutter analyze`
Expected: remaining errors only in `lib/src/ui/**` and `lib/main.dart`. Apply the playbook to every reported file (this is the bulk of the UI null-safety work — nullable `BuildContext` lookups, `required` widget params, nullable callback params).

- [ ] **Step 9: Re-run until the entire project is clean**

Run: `flutter analyze`
Expected: `No issues found!`

- [ ] **Step 10: Commit**

```bash
git add lib
git commit -m "refactor: null-safety migrate ui layer; url_launcher/share_plus/gal/showcaseview/fl_chart/package_info_plus swaps"
```

---

## Phase 3 — Android Build Modernization

### Task 3.1: Convert Android to embedding v2

**Files:**
- Create: `android/app/src/main/kotlin/com/krkadoni/app/signalmeter/MainActivity.kt`
- Delete: `android/app/src/main/java/com/krkadoni/app/signalmeter/MainActivity.java`
- Rewrite: `android/app/src/main/AndroidManifest.xml`

- [ ] **Step 1: Create the Kotlin MainActivity**

Create `android/app/src/main/kotlin/com/krkadoni/app/signalmeter/MainActivity.kt`:
```kotlin
package com.krkadoni.app.signalmeter

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity()
```

- [ ] **Step 2: Delete the old Java activity**

```bash
git rm android/app/src/main/java/com/krkadoni/app/signalmeter/MainActivity.java
```

- [ ] **Step 3: Rewrite AndroidManifest.xml for embedding v2**

Replace `android:name="io.flutter.app.FlutterApplication"` with `android:name="${applicationName}"`, and replace the old `SplashScreenUntilFirstFrame` meta-data with the v2 `flutterEmbedding` meta-data. Final `<application>`:
```xml
<application
    android:name="${applicationName}"
    android:label="SignalMeter"
    android:icon="@mipmap/ic_launcher">
    <activity
        android:name=".MainActivity"
        android:exported="true"
        android:launchMode="singleTop"
        android:theme="@style/LaunchTheme"
        android:configChanges="orientation|keyboardHidden|keyboard|screenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
        android:hardwareAccelerated="true"
        android:windowSoftInputMode="adjustResize">
        <meta-data
            android:name="io.flutter.embedding.android.NormalTheme"
            android:resource="@style/NormalTheme" />
        <intent-filter>
            <action android:name="android.intent.action.MAIN"/>
            <category android:name="android.intent.category.LAUNCHER"/>
        </intent-filter>
    </activity>
    <meta-data
        android:name="flutterEmbedding"
        android:value="2" />
</application>
```
Keep all existing `<uses-permission>` entries. Note `android:exported="true"` is required on the launcher activity for `targetSdk 31+`.

- [ ] **Step 4: Add the NormalTheme style if missing**

Check `android/app/src/main/res/values/styles.xml` for a `NormalTheme`. If absent, add:
```xml
<style name="NormalTheme" parent="@android:style/Theme.Light.NoTitleBar">
    <item name="android:windowBackground">?android:colorBackground</item>
</style>
```
(and the same in `values-night/styles.xml` if it exists).

- [ ] **Step 5: Commit**

```bash
git add android/app/src/main
git commit -m "build(android): migrate to embedding v2 (Kotlin MainActivity)"
```

### Task 3.2: Upgrade Gradle, AGP, and SDK levels

**Files:**
- Modify: `android/gradle/wrapper/gradle-wrapper.properties`
- Rewrite: `android/build.gradle`, `android/settings.gradle`, `android/app/build.gradle`
- Modify: `android/gradle.properties`

- [ ] **Step 1: Bump the Gradle wrapper to 8.x**

In `android/gradle/wrapper/gradle-wrapper.properties` set:
```
distributionUrl=https\://services.gradle.org/distributions/gradle-8.9-all.zip
```

- [ ] **Step 2: Rewrite android/settings.gradle to the plugins DSL**

```groovy
pluginManagement {
    def flutterSdkPath = {
        def properties = new Properties()
        file("local.properties").withInputStream { properties.load(it) }
        def flutterSdkPath = properties.getProperty("flutter.sdk")
        assert flutterSdkPath != null, "flutter.sdk not set in local.properties"
        return flutterSdkPath
    }()

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id "dev.flutter.flutter-plugin-loader" version "1.0.0"
    id "com.android.application" version "8.5.2" apply false
    id "org.jetbrains.kotlin.android" version "1.9.24" apply false
}

include ":app"
```

- [ ] **Step 3: Rewrite android/build.gradle (drop jcenter)**

```groovy
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.buildDir = "../build"
subprojects {
    project.buildDir = "${rootProject.buildDir}/${project.name}"
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register("clean", Delete) {
    delete rootProject.buildDir
}
```

- [ ] **Step 4: Rewrite android/app/build.gradle for AGP 8 (namespace, compileSdk 34, JDK 17, signing preserved)**

```groovy
plugins {
    id "com.android.application"
    id "kotlin-android"
    id "dev.flutter.flutter-gradle-plugin"
}

def localProperties = new Properties()
def localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
    localPropertiesFile.withReader("UTF-8") { reader ->
        localProperties.load(reader)
    }
}

def flutterVersionCode = localProperties.getProperty("flutter.versionCode") ?: "1"
def flutterVersionName = localProperties.getProperty("flutter.versionName") ?: "1.0"

def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.krkadoni.app.signalmeter"
    compileSdk = 34

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.krkadoni.app.signalmeter"
        minSdk = 23
        targetSdk = 34
        versionCode = flutterVersionCode.toInteger()
        versionName = flutterVersionName
    }

    signingConfigs {
        release {
            keyAlias = keystoreProperties["keyAlias"]
            keyPassword = keystoreProperties["keyPassword"]
            storeFile = keystoreProperties["storeFile"] ? file(keystoreProperties["storeFile"]) : null
            storePassword = keystoreProperties["storePassword"]
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.release
        }
    }
}

flutter {
    source = "../.."
}
```
> Set `minSdk` to the floor recorded in Task 1.1 Step 4 (use `23` unless a plugin requires higher).

- [ ] **Step 5: Trim gradle.properties**

In `android/gradle.properties` remove the deprecated `android.enableR8` and `android.enableJetifier` lines (R8 is default; Jetifier no longer needed). Keep:
```
org.gradle.jvmargs=-Xmx1536M
android.useAndroidX=true
```

- [ ] **Step 6: Confirm JDK 17 is what Gradle uses**

Run: `flutter doctor -v`
Expected: Android toolchain present; Java version 17. If Gradle uses a different JDK, set it via `flutter config --jdk-dir` or Android Studio's embedded JDK.

- [ ] **Step 7: Commit**

```bash
git add android/build.gradle android/settings.gradle android/app/build.gradle android/gradle.properties android/gradle/wrapper/gradle-wrapper.properties
git commit -m "build(android): AGP 8 / Gradle 8 / compileSdk 34 / mavenCentral"
```

### Task 3.3: First successful Android build

**Files:** none (build verification)

- [ ] **Step 1: Clean build artifacts**

Run: `flutter clean && flutter pub get`
Expected: completes without error.

- [ ] **Step 2: Build the debug APK**

Run: `flutter build apk --debug`
Expected: `Built build/app/outputs/flutter-apk/app-debug.apk`.

> **Contingency:** if the build fails on Gradle/AGP/plugin issues that resist fixing, regenerate the platform folder: `flutter create --platforms=android --org com.krkadoni.app .` then re-apply the signing config block, the manifest permissions/label, and launcher icons; re-commit. Document what was regenerated.

- [ ] **Step 3: Regenerate launcher icons**

Run: `dart run flutter_launcher_icons`
Expected: icons regenerated for android (and ios). Commit any changed icon assets.

- [ ] **Step 4: Run on a device/emulator (smoke)**

Run: `flutter run` (with a device/emulator attached)
Expected: app launches to the home screen without a red error screen. (Full functional verification happens in Phase 5.)

- [ ] **Step 5: Commit**

```bash
git add android
git commit -m "build(android): regenerate launcher icons; verified debug build"
```

### Task 3.4: Keep iOS buildable (config only)

**Files:**
- Modify: `ios/Podfile`, `ios/Runner.xcodeproj/project.pbxproj` (deployment target)

- [ ] **Step 1: Raise the iOS deployment target to 13.0**

In `ios/Runner.xcodeproj/project.pbxproj`, set every `IPHONEOS_DEPLOYMENT_TARGET = 9.0;` and `= 12.0;` to `= 13.0;`. In `ios/Podfile` set/uncomment `platform :ios, '13.0'`.

- [ ] **Step 2: Add Info.plist usage strings for new plugins**

In `ios/Runner/Info.plist`, ensure `NSPhotoLibraryAddUsageDescription` (for `gal` save) and `NSPhotoLibraryUsageDescription` exist with a human-readable reason. share_plus needs no key.

- [ ] **Step 3: Commit (iOS build itself deferred to Mac/CI)**

```bash
git add ios
git commit -m "build(ios): bump deployment target to 13.0; add photo-library usage strings"
```

---

## Phase 4 — Light Modernization

### Task 4.1: Switch lints to flutter_lints

**Files:**
- Modify: `analysis_options.yaml`

- [ ] **Step 1: Replace the pedantic include with flutter_lints**

Rewrite `analysis_options.yaml`:
```yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  exclude:
    - lib/src/i18n/**

linter:
  rules:
```

- [ ] **Step 2: Run the analyzer and address new lints**

Run: `flutter analyze`
Expected: possibly new lint warnings (prefer_const, unnecessary_this, etc.). Fix mechanically, or disable a specific noisy rule under `linter: rules:` with a one-line justification comment. Errors must reach zero.

- [ ] **Step 3: Commit**

```bash
git add analysis_options.yaml lib
git commit -m "chore: adopt flutter_lints and fix resulting warnings"
```

### Task 4.2: Dead-code cleanup

**Files:** as surfaced

- [ ] **Step 1: Find dead code**

Run: `dart analyze --fatal-infos 2>&1 | grep -iE "unused|dead_code"` (or rely on Task 4.1 output).
Expected: list of unused imports/fields/elements.

- [ ] **Step 2: Remove unused imports, fields, and commented-out blocks**

Delete only clearly dead code (unused imports, unreferenced private members, commented-out legacy blocks). No behavioral refactors.

- [ ] **Step 3: Verify still clean and commit**

Run: `flutter analyze`
Expected: `No issues found!`
```bash
git add lib
git commit -m "chore: remove dead code surfaced during migration"
```

> **Out of scope (documented):** full `intl_translation` → `gen-l10n` migration. It requires rewriting `MessageProvider.of(context)` across 40+ call sites and re-homing the custom `getTranslatedLocale`/`getWebLanguageCode` web-language logic. Tracked as a future task; not done here.

---

## Phase 5 — Test Safety Net & Verification

### Task 5.1: Replace the default widget test

**Files:**
- Modify: `test/widget_test.dart`

- [ ] **Step 1: Check the existing default test compiles**

Run: `flutter test test/widget_test.dart`
Expected: likely FAILS (references old `MyApp`/pre-null-safety API).

- [ ] **Step 2: Replace it with a minimal smoke test or delete**

If it references a non-existent widget, replace its body with a trivial passing test or remove the file; real coverage comes from the tasks below.
```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('placeholder until real tests added', () {
    expect(1 + 1, 2);
  });
}
```

- [ ] **Step 3: Commit**

```bash
git add test/widget_test.dart
git commit -m "test: reset default widget test"
```

### Task 5.2: Reducer unit tests

**Files:**
- Create: `test/unit/redux/app_state_reducer_test.dart` (plus one per key reducer)

- [ ] **Step 1: Write a failing reducer test**

Pick a pure reducer (e.g. the bouquets or signal reducer). Example shape — adapt to the real reducer/event/state names:
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state_reducer.dart';

void main() {
  group('appReducer', () {
    test('returns a new state for an unknown action without mutating input', () {
      final initial = AppState.initial();
      final result = appReducer(initial, Object());
      expect(result, isA<AppState>());
    });
  });
}
```

- [ ] **Step 2: Run to verify it fails (then passes)**

Run: `flutter test test/unit/redux/app_state_reducer_test.dart`
Expected: compile/assert until the real reducer + `AppState.initial()` names are wired correctly, then PASS.

- [ ] **Step 3: Add focused tests for 2-3 key reducers**

Cover a state transition that matters (e.g. a "loaded" event populating state, an "error" event setting an error field). Assert the specific changed field and that unrelated fields are unchanged.

- [ ] **Step 4: Commit**

```bash
git add test/unit/redux
git commit -m "test: add reducer unit tests"
```

### Task 5.3: Widget test for a core screen

**Files:**
- Create: `test/widget/signal_view_test.dart` (or the connect/home flow)

- [ ] **Step 1: Write a widget test pumping a screen with a mocked store**

Build a `Store<AppState>` with a fixed initial state, wrap the widget in `StoreProvider` + the `Localizations`/`MaterialApp` scaffold, and assert a known label renders.
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
// import the screen + reducer under test

void main() {
  testWidgets('home screen renders without error', (tester) async {
    final store = Store<AppState>(
      (state, action) => state,
      initialState: AppState.initial(),
    );
    await tester.pumpWidget(
      StoreProvider<AppState>(
        store: store,
        child: const MaterialApp(home: SizedBox()), // replace with screen + delegates
      ),
    );
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
```

- [ ] **Step 2: Run the test**

Run: `flutter test test/widget/signal_view_test.dart`
Expected: PASS. (If the screen needs `MessageProvider`, add the `localizationsDelegates`/`supportedLocales` from `main.dart` to the test `MaterialApp`.)

- [ ] **Step 3: Run the full suite**

Run: `flutter test`
Expected: all green.

- [ ] **Step 4: Commit**

```bash
git add test/widget
git commit -m "test: add core-screen widget test"
```

### Task 5.4: Manual end-to-end verification on Android

**Files:** none

- [ ] **Step 1: Build and install a release-mode (or debug) build on a real device**

Run: `flutter run --release` (device attached, on the same network as an Enigma receiver).
Expected: app launches.

- [ ] **Step 2: Exercise the core flows against a real receiver**

Verify each manually and note results:
- Add/connect to an Enigma1/Enigma2 profile.
- Read live signal levels (progress bar, circular, and chart views).
- Browse bouquets and services; zap to a channel.
- Send a message to the receiver.
- Take a screenshot; share it; save it to the gallery.
- TTS announces signal (if enabled).
- Rotate to the full-screen chart (orientation change).

- [ ] **Step 3: Record verification results**

Append a short "Verification" note to this plan file (date, device, Android version, receiver model, pass/fail per flow). Commit.
```bash
git add docs/superpowers/plans/2026-06-08-flutter-modernization.md
git commit -m "docs: record manual verification results"
```

---

## Self-Review Checklist (completed by plan author)

- **Spec coverage:** every spec section maps to tasks — null safety (Phase 2), Android-first build incl. embedding v2 (Phase 3), iOS lockstep (Task 3.4), plugin inventory incl. all higher-risk swaps (Phase 2 tasks 2.3/2.5), permission_handler fork dropped (Task 1.1), light mod lints/cleanup (Phase 4), gen-l10n deferred with rationale (Task 4.2 note), test safety net (Phase 5), enigma_web path dep (Task 0.2). ✓
- **Big-bang reality:** documented that the project won't analyze/build until Phase 2/3 complete. ✓
- **Type consistency:** `WakelockPlus`, `launchUrl(Uri.parse(...))`, `Share.shareXFiles`/`XFile.fromData`, `Gal.putImageBytes`, `getTitlesWidget`, `gradient:` used consistently across tasks. ✓
- **Null-safety availability audit:** every dependency was checked for a null-safe release. The only holdout is `flutter_flip_view` (no null-safe version on pub.dev) — handled via the local fork migration in Task 0.3 + path dep. All others (flutter_redux 0.10, flutter_redux_navigation 0.8, percent_indicator 4, photo_view 0.15, etc.) have null-safe releases. ✓
- **Known gaps (intentional):** exact per-file null-safety edits are analyzer-driven (cannot be pre-scripted for ~162 files); plugin version numbers are pinned-at-resolve (`flutter pub get` may adjust a line). Both are called out where they occur.
