# Flutter Modernization — Design Spec

**Date:** 2026-06-08
**Project:** enigma_signal_meter (Signalmeter2)
**Author:** shaxxx

## Goal

Bring this pre-null-safety Flutter app up to the current Flutter/Dart toolchain
(installed: Flutter 3.41 / Dart 3.11) and update all plugins to maintained
versions. Scope is **build + light modernization**: get it compiling, shipping,
and running again; adopt current API idioms where plugins force it; tidy lints
and i18n tooling. **No architecture changes** (Redux stays).

## Constraints & Key Facts

- **Dart 3 forbids mixed-mode null safety.** Pre-null-safety code cannot run on
  Dart 3.11 at all. The entire codebase (~162 Dart files) plus every dependency
  must be null-safe in a single pass. This migration is inherently "big bang":
  it will not compile or run until the null-safety work is essentially complete.
  `dart migrate` no longer exists in Dart 3, so migration is manual, guided by
  the analyzer.
- **Platforms: Android-first, keep iOS buildable.** All hands-on work and
  verification happen on Android (buildable on the user's Windows machine). iOS
  config is kept in lockstep (plugin versions, Podfile, deployment target) but
  actual iOS build/test is deferred to a Mac/CI.
- **`enigma_web` is already null-safe.** The author (same user) has migrated it
  to `2.0.0` (SDK `>=3.0.0`, `dio 5.x`, `xml 6.x`), available locally at
  `C:\Users\isako\source\repos\EnigmaWeb.Dart`. During migration the app points
  at it via a **path dependency**; switch back to a published version before
  release.
- **Android is on embedding v1** (`io.flutter.app.FlutterApplication`, Java
  `MainActivity`). Flutter 3.x requires **embedding v2** — a mandatory
  conversion. No Kotlin is configured yet.
- **Verification:** manual testing on an Android device/emulator against a real
  Enigma1/Enigma2 receiver, **plus** a safety net of automated tests (Redux
  reducers + a handful of widget tests) added before the risky plugin swaps.

## Approach

Single sequenced track, one branch/worktree, phased plan with a review
checkpoint at each phase. Because the phases are tightly coupled (nothing
compiles until null safety lands), decomposing into independent spec cycles or
parallelizing module migration across agents buys little and adds coordination
cost — rejected in favor of one ordered pass.

### Phase 0 — Prep & pin
- Bump `environment: sdk` to `>=3.0.0 <4.0.0`.
- Point `enigma_web` at the local path dependency
  (`C:\Users\isako\source\repos\EnigmaWeb.Dart`).
- Align `xml` to `^6.5.0` to match `enigma_web`.
- Create the migration branch/worktree.

### Phase 1 — Dependency resolution
- Update `pubspec.yaml` with target versions / replacements (table below).
- Drop the `permission_handler` git fork → official `permission_handler ^12.x`
  (the missing intent parameters that motivated the fork are upstreamed).
- Get `flutter pub get` to resolve cleanly; record the resulting `minSdk` floor
  imposed by the new plugins.

### Phase 2 — Null-safety migration (the big one)
- Migrate all ~162 files manually, module by module in dependency order
  (`model/` → `redux/` → presentation/widgets), driving `flutter analyze` to
  clean.
- Adapt to changed plugin APIs as encountered (see higher-risk table).
- Gate: `flutter analyze` clean.

### Phase 3 — Build modernization
**Android:**
- Embedding v1 → v2: Java `MainActivity` → Kotlin `MainActivity` extending
  `io.flutter.embedding.android.FlutterActivity`; rewrite `AndroidManifest.xml`
  (remove `io.flutter.app.FlutterApplication`, add `flutterEmbedding` v2
  meta-data, replace old `SplashScreenUntilFirstFrame` mechanism).
- Gradle `4.10.2` → `8.x`; AGP `3.3.0` → `8.x`; migrate to modern
  `settings.gradle` plugins{} DSL.
- Remove dead `jcenter()` → `mavenCentral()`.
- `compileSdk`/`targetSdk` `28` → `34` (or `35`); `minSdk` raised to the plugin
  floor recorded in Phase 1.
- Add Kotlin Gradle plugin + current Kotlin version. AGP 8 requires JDK 17.
- Bump `flutter_launcher_icons` (`^0.14.x`, config key renamed to
  `flutter_launcher_icons:`) and regenerate icons.

**iOS (kept buildable, verified later):**
- Bump `IPHONEOS_DEPLOYMENT_TARGET` 9.0/12.0 → `13.0`.
- Refresh `Podfile` platform line; update `Info.plist` usage strings for new
  plugins (photos/camera for `gal`/`share_plus`) as needed.
- Defer `pod install` / device build to Mac/CI.

**Contingency:** if the in-place AGP-8 / embedding-v2 upgrade fights us,
regenerate `android/` (and `ios/`) shells from `flutter create` into the package
id `com.krkadoni.app.signalmeter` and port back app-specific bits (signing
config, icons, permissions, intent filters, app label).

### Phase 4 — Light modernization
- **i18n:** migrate `intl_translation` → built-in `gen-l10n` (`.arb` files +
  `flutter_localizations`), keeping all locales (en, ca, de, es, fr, hr, it, nl,
  ru, zh). **Deferrable fallback:** if noisy, keep a null-safe `intl_translation`
  and defer.
- **Lints:** `pedantic 1.9.0` → `flutter_lints ^5.x`; update
  `analysis_options.yaml`; fix or justify warnings.
- **Cleanup:** remove dead/commented code surfaced during migration. Adopt only
  plugin-forced API idioms — no gratuitous refactors.

### Phase 5 — Test safety net & verification
- Unit tests for Redux reducers (pure, high value) and key middleware logic.
- A few widget tests for core screens (connect flow, signal display) with mocked
  store state.
- Gate per Dart-touching phase: `flutter analyze` clean, `flutter test` green.
- Final manual run on Android against a real receiver: connect, read signal
  levels, browse bouquets, zap, send message, screenshot/share, TTS.

## Plugin Inventory & Targets

Target versions are indicative; each is pinned against pub.dev at planning time.

### Mechanical swaps (rename / version bump)
| Current | Target | Note |
|---|---|---|
| `wakelock ^0.1.4` | `wakelock_plus ^1.x` | `WakelockPlus.enable()` |
| `package_info ^0.4.0` | `package_info_plus ^8.x` | API ~same |
| `android_intent ^0.3.7` | `android_intent_plus ^5.x` | API ~same |
| `flushbar ^1.10.4` | `another_flushbar ^1.12.x` | drop-in-ish |
| `flutter_redux ^0.6.0` | `^0.10.x` | null-safe |
| `flutter_redux_navigation ^0.6.0` | `^0.8.x` | null-safe |
| `shared_preferences ^0.5.7` | `^2.x` | API ~same |
| `percent_indicator ^2.1.3` | `^4.x` | minor |
| `auto_size_text ^2.1.0` | `^3.x` | minor |
| `photo_view ^0.9.2` | `^0.15.x` | minor |
| `xml ^3.5.0` | `^6.5.0` | match enigma_web |

### Higher-risk (real API rewrites)
| Current | Target | Why |
|---|---|---|
| `fl_chart ^0.9.4` | `^0.69/1.x` | chart API changed substantially; chart widgets rewritten |
| `url_launcher ^5.4.7` | `^6.x` | new `launchUrl()` API |
| `wc_flutter_share ^0.2.2` | `share_plus ^10.x` | different file-share API |
| `flutter_tts ^1.2.0` | `^4.x` | API changes |
| `showcaseview ^0.1.5` | `^3/4.x` | significantly changed API |

### Investigation / decision needed
| Current | Likely path |
|---|---|
| `permission_handler` (git fork) | **Resolved:** official `^12.x` (fork no longer needed) |
| `image_gallery_saver ^1.2.2` | discontinued → `gal ^2.x` or `image_gallery_saver_plus` |
| `auto_orientation ^1.0.6` | unmaintained → native `SystemChrome` or `auto_orientation_v2` |
| `flutter_flip_view ^1.0.3` | verify maintenance; keep or replace |

### Dev dependencies
| Current | Target |
|---|---|
| `intl_translation ^0.17.8` | removed → `gen-l10n` (with deferrable fallback) |
| `flutter_launcher_icons ^0.7.4` | `^0.14.x` (config key renamed) |
| `pedantic 1.9.0` | `flutter_lints ^5.x` |

## Risks

1. **Embedding-v2 + AGP-8 jump** — the single most failure-prone task.
   Mitigated by the `flutter create` regeneration contingency.
2. **Big-bang null safety** — no partial verification until it compiles.
   Mitigated by migrating in dependency order and leaning on the analyzer; the
   already-null-safe `enigma_web` removes the largest external unknown.
3. **High-risk plugin API rewrites** (`fl_chart`, `share_plus`, `flutter_tts`,
   `showcaseview`) — mitigated by the test safety net added before swaps and
   manual end-to-end verification.
4. **gen-l10n migration noise** — mitigated by the deferrable fallback to
   null-safe `intl_translation`.

## Out of Scope

- Architecture changes (Redux stays; no state-management migration).
- Material 3 / visual redesign.
- New features.
- Full iOS verification (deferred to Mac/CI).
- Exhaustive test coverage (safety net only).
