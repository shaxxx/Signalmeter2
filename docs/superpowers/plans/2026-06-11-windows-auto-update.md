# Windows Auto-Update Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** In-place auto-update for the Windows build: check at startup, optional dialog (mandatory lever honored), differential download, exit–swap–relaunch.

**Architecture:** Port BRKO's `desktop_updater` integration: a `DesktopUpdater` interface seam with exactly one plugin-importing client, a self-contained update dialog with a local state machine (prompt / permission-blocked / downloading / restart / error), and a startup checker hooked into the home view. ACL problem solved in-app via a one-time elevated `icacls` grant.

**Tech Stack:** Flutter + Redux app (dialog is store-free), `desktop_updater ^2.0.0-dev.1`, `version`, existing `intl_translation` i18n toolchain (10 locales).

**Spec:** `docs/superpowers/specs/2026-06-11-windows-auto-update-design.md`
**Reference:** BRKO at `C:\zeba\Kase\Kase2023\Ugostiteljska\flutter` (read-only; TFVC conventions do NOT apply — Signalmeter2 is git).

---

## Context for the engineer

- Repo root: `c:\Users\isako\source\repos\Signalmeter2`, PowerShell. Work on branch `feature/windows-auto-update` (Task 1 creates it from `master`).
- **Line endings: this repo stores source as LF.** Two prior incidents of whole-file CRLF churn were caught in review. Use surgical edits; after every task `git diff --stat` must show small hunk counts. New `.dart` files: LF.
- `flutter analyze` baseline: **56 info/warning items, zero errors** (none in files this plan touches except `home_view.dart`'s pre-existing showcase deprecations). "Analyze clean" = no NEW items. `flutter test` currently: **11/11 pass**.
- `pubspec.lock` and `.metadata` are **gitignored** in this repo — never try to stage them.
- `lib/src/i18n/**` is excluded from analysis (generated files); its `.arb` + `messages_*.dart` files ARE committed — commit regenerated output.
- Never `git add -A`. Stage exact paths.
- Verified plugin facts (desktop_updater 2.0.0-dev.1, read from pub-cache source — do not "fix" code to match BRKO's spec document, which sketches an older API):
  - `versionCheck(appArchiveUrl:)` filters manifest items by `platform == Platform.operatingSystem`, picks max integer `shortVersion`, returns **null when `shortVersion <=` current build number** or when the hash diff shows no changed/removed files; otherwise returns the `ItemModel` with `changedFiles`/`removedFiles` populated.
  - Current build number on Windows = the integer after `+` in the exe's **ProductVersion** resource (errors if no `+`). Flutter embeds pubspec's full version string (`1.1.2+5001`) there.
  - `ItemModel`: `version` String (display), `shortVersion` **int** (ordering), `mandatory` bool, `url` String (folder containing `hashes.json` + files; keep trailing `/`), `changes` list of `{type?, message}`.
  - `updateApp(remoteUpdateFolder:, changedFiles:)` → `Future<Stream<UpdateProgress>>`; `UpdateProgress` has `fraction` (0..1) and `stagingDirectory`.
  - `installUpdate(stagingPath:, removedFiles:)` exits, swaps, relaunches.
  - Release tooling: `dart run desktop_updater:release windows` (flutter release build → `dist\<build>\<name>-<ver>+<build>-windows\`), then `dart run desktop_updater:archive windows` (copies to `dist\<build>\<ver>+<build>-windows\` + writes Blake2b `hashes.json`).

---

### Task 1: Branch, dependencies, seam, test fake

**Files:**
- Create: `lib/src/model/desktop_updater.dart`
- Create: `test/helpers/fake_desktop_updater.dart`
- Modify: `pubspec.yaml` (via `flutter pub add`)

- [ ] **Step 1: Create branch**

```powershell
git checkout master
git checkout -b feature/windows-auto-update
```

- [ ] **Step 2: Retire the ProductVersion risk early**

The whole mechanism depends on the exe's ProductVersion containing `+<build>`. Verify on the already-built release exe:

```powershell
(Get-Item "build\windows\x64\runner\Release\enigma_signal_meter.exe").VersionInfo.ProductVersion
```

Expected: `1.1.2+5001`. If the exe is missing, run `flutter build windows --release` first (600000 ms timeout). If the output has no `+`, STOP and report BLOCKED — the plugin's `getCurrentVersion` would fail.

- [ ] **Step 3: Add dependencies**

```powershell
flutter pub add "desktop_updater:^2.0.0-dev.1" version
```

Expected: both resolve (`desktop_updater 2.0.0-dev.1`, `version 3.x`). Only `pubspec.yaml` changes (lock is gitignored). Note: pub writes the prerelease back as an exact pin (`desktop_updater: 2.0.0-dev.1`, no caret) — keep it; an exact pin is the deliberate choice for a prerelease.

- [ ] **Step 4: Create the seam**

Create `lib/src/model/desktop_updater.dart` (BRKO port; no plugin import here):

```dart
import 'package:version/version.dart';

/// Result of checking the remote manifest for a newer version.
class DesktopUpdateAvailability {
  const DesktopUpdateAvailability({
    required this.latest,
    required this.isMandatory,
    this.releaseNotes,
  });

  /// Newest version advertised for this platform, or null when the app is
  /// up to date / no platform entry exists / the plugin found no file diff.
  final Version? latest;

  /// True when the manifest entry sets `mandatory: true` — the dialog then
  /// hides "Later" and blocks dismissal.
  final bool isMandatory;

  /// Joined `changes[].message` lines from the manifest, or null.
  final String? releaseNotes;
}

/// Progress events emitted by [DesktopUpdater.startUpdate].
///
/// Failures are reported as a [DesktopUpdateFailed] event followed by stream
/// completion — never as stream errors — so consumers need no onError branch.
sealed class DesktopUpdateProgress {
  const DesktopUpdateProgress();
}

class DesktopUpdateDownloading extends DesktopUpdateProgress {
  const DesktopUpdateDownloading(this.progress);

  /// Download progress as a fraction from 0.0 to 1.0.
  final double progress;
}

class DesktopUpdateStaged extends DesktopUpdateProgress {
  const DesktopUpdateStaged(this.newVersion);

  /// Version fully downloaded and hash-verified into the staging directory.
  final Version newVersion;
}

class DesktopUpdateFailed extends DesktopUpdateProgress {
  const DesktopUpdateFailed(this.message);

  final String message;
}

/// Application-facing seam for desktop auto-update.
///
/// The production implementation lives in
/// `lib/src/utils/desktop_updater_client.dart` and is the ONLY place that
/// imports `package:desktop_updater`. Everything else depends on this
/// interface so it can be tested with a fake.
abstract interface class DesktopUpdater {
  /// Reads the remote manifest. `latest == null` means "nothing to do".
  Future<DesktopUpdateAvailability> checkAvailability();

  /// Downloads + stages changed files. Emits Downloading events, then exactly
  /// one Staged OR one Failed, then closes.
  Stream<DesktopUpdateProgress> startUpdate();

  /// Exits the app; the native helper swaps staged files and relaunches.
  /// Only valid after a Staged event.
  Future<void> restartAndApply();
}
```

- [ ] **Step 5: Create the test fake**

Create `test/helpers/fake_desktop_updater.dart` (BRKO port, adjusted import):

```dart
import 'dart:async';

import 'package:enigma_signal_meter/src/model/desktop_updater.dart';
import 'package:version/version.dart';

/// Controllable in-memory [DesktopUpdater] for tests. Configure
/// [availability], [progressEvents], and [restartShouldThrow]; the fake
/// records call counts for assertions.
class FakeDesktopUpdater implements DesktopUpdater {
  DesktopUpdateAvailability availability = const DesktopUpdateAvailability(
    latest: null,
    isMandatory: false,
  );

  /// Events emitted by [startUpdate] in order; the stream completes after
  /// the last one.
  List<DesktopUpdateProgress> progressEvents = const [];

  bool restartShouldThrow = false;

  /// When set, [checkAvailability] throws instead of returning.
  Object? checkError;

  int checkAvailabilityCalls = 0;
  int startUpdateCalls = 0;
  int restartAndApplyCalls = 0;

  @override
  Future<DesktopUpdateAvailability> checkAvailability() async {
    checkAvailabilityCalls++;
    final error = checkError;
    if (error != null) {
      throw error;
    }
    return availability;
  }

  @override
  Stream<DesktopUpdateProgress> startUpdate() {
    startUpdateCalls++;
    final controller = StreamController<DesktopUpdateProgress>();
    scheduleMicrotask(() async {
      for (final event in progressEvents) {
        controller.add(event);
      }
      await controller.close();
    });
    return controller.stream;
  }

  @override
  Future<void> restartAndApply() async {
    restartAndApplyCalls++;
    if (restartShouldThrow) {
      throw Exception('restart failed');
    }
  }

  void setUpdateAvailable(Version version, {bool isMandatory = false}) {
    availability = DesktopUpdateAvailability(
      latest: version,
      isMandatory: isMandatory,
    );
  }
}
```

- [ ] **Step 6: Verify**

Run: `flutter analyze` → 56 items (no new). Run: `flutter test` → 11/11.

- [ ] **Step 7: Commit**

```powershell
git add pubspec.yaml lib/src/model/desktop_updater.dart test/helpers/fake_desktop_updater.dart
git commit -m "feat(update): desktop updater seam, fake, and dependencies"
```

---

### Task 2: install_dir_access — writability probe + elevated grant (TDD)

**Files:**
- Create: `lib/src/utils/install_dir_access.dart`
- Test: `test/unit/utils/install_dir_access_test.dart`

- [ ] **Step 1: Write the failing test**

Create `test/unit/utils/install_dir_access_test.dart`:

```dart
import 'dart:io';

import 'package:enigma_signal_meter/src/utils/install_dir_access.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isDirWritable', () {
    test('returns true for a writable directory', () async {
      final tempDir =
          await Directory.systemTemp.createTemp('install_dir_access');
      addTearDown(() => tempDir.delete(recursive: true));

      expect(await isDirWritable(tempDir), isTrue);
    });

    test('leaves no probe file behind', () async {
      final tempDir =
          await Directory.systemTemp.createTemp('install_dir_access');
      addTearDown(() => tempDir.delete(recursive: true));

      await isDirWritable(tempDir);

      expect(tempDir.listSync(), isEmpty);
    });

    test('returns false for a non-existent directory', () async {
      final missing = Directory(
        '${Directory.systemTemp.path}${Platform.pathSeparator}no_such_dir_12345',
      );
      expect(await isDirWritable(missing), isFalse);
    });
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `flutter test test/unit/utils/install_dir_access_test.dart`
Expected: FAIL — compilation error, `install_dir_access.dart` does not exist.

- [ ] **Step 3: Implement**

Create `lib/src/utils/install_dir_access.dart`:

```dart
import 'dart:io';

import 'package:logging/logging.dart';

final Logger _log = Logger('InstallDirAccess');

/// True when [dir] is effectively writable by the current user, proven by
/// creating and deleting a probe file (tests real ACLs, not attributes).
Future<bool> isDirWritable(Directory dir) async {
  final probe = File(
    '${dir.path}${Platform.pathSeparator}'
    '.esm_write_probe_${DateTime.now().microsecondsSinceEpoch}',
  );
  try {
    await probe.writeAsBytes(const [0], flush: true);
    await probe.delete();
    return true;
  } catch (_) {
    try {
      if (await probe.exists()) {
        await probe.delete();
      }
    } catch (_) {}
    return false;
  }
}

/// The folder the running executable lives in — the update target.
Directory installDir() => File(Platform.resolvedExecutable).parent;

/// True when the app's install folder is writable by the current user.
Future<bool> isInstallDirWritable() => isDirWritable(installDir());

/// Asks Windows (one UAC prompt) to grant the current user Modify rights on
/// the install folder, then re-probes. The probe result is the source of
/// truth — exit codes of the elevated process are not reliable.
Future<bool> grantInstallDirAccess() async {
  final dir = installDir().path;
  final user = Platform.environment['USERNAME'];
  if (user == null || user.isEmpty) {
    _log.warning('USERNAME not set; cannot grant access');
    return false;
  }
  try {
    final process = await Process.start('powershell', [
      '-NoProfile',
      '-Command',
      'Start-Process icacls -Verb RunAs -Wait -ArgumentList '
          '\'"$dir" /grant "$user":(OI)(CI)M\'',
    ]);
    await process.exitCode;
  } catch (e) {
    _log.warning('Elevated icacls launch failed: $e');
  }
  return isInstallDirWritable();
}
```

- [ ] **Step 4: Run test to verify it passes**

Run: `flutter test test/unit/utils/install_dir_access_test.dart`
Expected: PASS (3 tests).

- [ ] **Step 5: Full verify + commit**

Run: `flutter analyze` (no new items) and `flutter test` (14/14).

```powershell
git add lib/src/utils/install_dir_access.dart test/unit/utils/install_dir_access_test.dart
git commit -m "feat(update): install-dir writability probe and elevated ACL grant"
```

---

### Task 3: i18n — 12 new message keys in 10 locales

**Files:**
- Modify: `lib/src/i18n/messages.dart` (append getters inside `class Messages`)
- Modify: all `lib/src/i18n/intl_messages*.arb` (en regenerated; 9 locale files hand-edited)
- Regenerated: `lib/src/i18n/messages_*.dart`

- [ ] **Step 1: Check for a reusable Close label**

Run: `Select-String -Path lib\src\i18n\messages.dart -Pattern "'Close'"`
If a getter with the exact English text `Close` exists, reuse it everywhere this plan says `updateActionClose` and skip adding that key (and its translations). If none exists (expected), add all 12 keys below.

- [ ] **Step 2: Append getters to `class Messages`** (before the class's closing brace in `lib/src/i18n/messages.dart`):

```dart
  String get updateAvailableTitle => Intl.message(
        'Update available',
        name: 'updateAvailableTitle',
      );
  String updateAvailableBody(String version) => Intl.message(
        'Version $version is available.',
        args: [version],
        name: 'updateAvailableBody',
      );
  String get updateActionUpdate => Intl.message(
        'Update',
        name: 'updateActionUpdate',
      );
  String get updateActionLater => Intl.message(
        'Later',
        name: 'updateActionLater',
      );
  String get updateDownloading => Intl.message(
        'Downloading update…',
        name: 'updateDownloading',
      );
  String get updateRestartBody => Intl.message(
        'Update downloaded. Restart to apply.',
        name: 'updateRestartBody',
      );
  String get updateActionRestart => Intl.message(
        'Restart',
        name: 'updateActionRestart',
      );
  String get updateFailedBody => Intl.message(
        'Update failed.',
        name: 'updateFailedBody',
      );
  String get updateActionClose => Intl.message(
        'Close',
        name: 'updateActionClose',
      );
  String get updatePermissionBody => Intl.message(
        'The app folder is not writable. Grant permission to enable updates.',
        name: 'updatePermissionBody',
      );
  String get updateActionGrant => Intl.message(
        'Allow',
        name: 'updateActionGrant',
      );
  String get updatePermissionFailedBody => Intl.message(
        'Permission was not granted. Move the app to a writable folder, or run it once as administrator.',
        name: 'updatePermissionFailedBody',
      );
```

- [ ] **Step 3: Extract English ARB**

```powershell
dart run intl_translation:extract_to_arb --output-dir=lib/src/i18n lib/src/i18n/messages.dart --locale=en
```

Expected: `lib/src/i18n/intl_messages.arb` regenerated, now containing the 12 new keys (plus `@key` metadata).

- [ ] **Step 4: Add translations to the 9 locale ARBs**

Append these key/value pairs inside the JSON object of each `intl_messages_<locale>.arb` (keep `{version}` placeholders verbatim; these are length-balanced per the spec — do not rewrite them):

`intl_messages_de.arb`:
```json
"updateAvailableTitle": "Update verfügbar",
"updateAvailableBody": "Version {version} ist verfügbar.",
"updateActionUpdate": "Aktualisieren",
"updateActionLater": "Später",
"updateDownloading": "Update wird geladen…",
"updateRestartBody": "Update geladen. Zum Anwenden neu starten.",
"updateActionRestart": "Neu starten",
"updateFailedBody": "Update fehlgeschlagen.",
"updateActionClose": "Schließen",
"updatePermissionBody": "Der App-Ordner ist schreibgeschützt. Erteilen Sie die Berechtigung für Updates.",
"updateActionGrant": "Erlauben",
"updatePermissionFailedBody": "Berechtigung nicht erteilt. Verschieben Sie die App in einen beschreibbaren Ordner oder starten Sie sie einmal als Administrator."
```

`intl_messages_es.arb`:
```json
"updateAvailableTitle": "Actualización disponible",
"updateAvailableBody": "La versión {version} está disponible.",
"updateActionUpdate": "Actualizar",
"updateActionLater": "Más tarde",
"updateDownloading": "Descargando actualización…",
"updateRestartBody": "Actualización descargada. Reinicia para aplicarla.",
"updateActionRestart": "Reiniciar",
"updateFailedBody": "Error al actualizar.",
"updateActionClose": "Cerrar",
"updatePermissionBody": "La carpeta de la aplicación no es escribible. Concede permiso para habilitar actualizaciones.",
"updateActionGrant": "Permitir",
"updatePermissionFailedBody": "No se concedió el permiso. Mueve la aplicación a una carpeta escribible o ejecútala una vez como administrador."
```

`intl_messages_fr.arb`:
```json
"updateAvailableTitle": "Mise à jour disponible",
"updateAvailableBody": "La version {version} est disponible.",
"updateActionUpdate": "Mettre à jour",
"updateActionLater": "Plus tard",
"updateDownloading": "Téléchargement de la mise à jour…",
"updateRestartBody": "Mise à jour téléchargée. Redémarrez pour l'appliquer.",
"updateActionRestart": "Redémarrer",
"updateFailedBody": "Échec de la mise à jour.",
"updateActionClose": "Fermer",
"updatePermissionBody": "Le dossier de l'application n'est pas accessible en écriture. Accordez l'autorisation pour activer les mises à jour.",
"updateActionGrant": "Autoriser",
"updatePermissionFailedBody": "Autorisation refusée. Déplacez l'application vers un dossier accessible en écriture ou exécutez-la une fois en tant qu'administrateur."
```

`intl_messages_it.arb`:
```json
"updateAvailableTitle": "Aggiornamento disponibile",
"updateAvailableBody": "La versione {version} è disponibile.",
"updateActionUpdate": "Aggiorna",
"updateActionLater": "Più tardi",
"updateDownloading": "Download dell'aggiornamento…",
"updateRestartBody": "Aggiornamento scaricato. Riavvia per applicarlo.",
"updateActionRestart": "Riavvia",
"updateFailedBody": "Aggiornamento non riuscito.",
"updateActionClose": "Chiudi",
"updatePermissionBody": "La cartella dell'app non è scrivibile. Concedi il permesso per abilitare gli aggiornamenti.",
"updateActionGrant": "Consenti",
"updatePermissionFailedBody": "Permesso non concesso. Sposta l'app in una cartella scrivibile o eseguila una volta come amministratore."
```

`intl_messages_nl.arb`:
```json
"updateAvailableTitle": "Update beschikbaar",
"updateAvailableBody": "Versie {version} is beschikbaar.",
"updateActionUpdate": "Bijwerken",
"updateActionLater": "Later",
"updateDownloading": "Update downloaden…",
"updateRestartBody": "Update gedownload. Herstart om toe te passen.",
"updateActionRestart": "Herstarten",
"updateFailedBody": "Update mislukt.",
"updateActionClose": "Sluiten",
"updatePermissionBody": "De app-map is niet beschrijfbaar. Verleen toestemming om updates mogelijk te maken.",
"updateActionGrant": "Toestaan",
"updatePermissionFailedBody": "Toestemming niet verleend. Verplaats de app naar een beschrijfbare map of voer deze eenmaal uit als administrator."
```

`intl_messages_ca.arb`:
```json
"updateAvailableTitle": "Actualització disponible",
"updateAvailableBody": "La versió {version} està disponible.",
"updateActionUpdate": "Actualitza",
"updateActionLater": "Més tard",
"updateDownloading": "Baixant l'actualització…",
"updateRestartBody": "Actualització baixada. Reinicia per aplicar-la.",
"updateActionRestart": "Reinicia",
"updateFailedBody": "Ha fallat l'actualització.",
"updateActionClose": "Tanca",
"updatePermissionBody": "La carpeta de l'aplicació no és escrivible. Concedeix permís per habilitar les actualitzacions.",
"updateActionGrant": "Permet",
"updatePermissionFailedBody": "No s'ha concedit el permís. Mou l'aplicació a una carpeta escrivible o executa-la un cop com a administrador."
```

`intl_messages_hr.arb`:
```json
"updateAvailableTitle": "Dostupna nadogradnja",
"updateAvailableBody": "Dostupna je verzija {version}.",
"updateActionUpdate": "Nadogradi",
"updateActionLater": "Kasnije",
"updateDownloading": "Preuzimanje nadogradnje…",
"updateRestartBody": "Nadogradnja preuzeta. Ponovno pokreni za primjenu.",
"updateActionRestart": "Ponovno pokreni",
"updateFailedBody": "Nadogradnja nije uspjela.",
"updateActionClose": "Zatvori",
"updatePermissionBody": "Mapa aplikacije nije zapisiva. Dodijelite dozvolu za omogućavanje nadogradnje.",
"updateActionGrant": "Dopusti",
"updatePermissionFailedBody": "Dozvola nije dodijeljena. Premjestite aplikaciju u zapisivu mapu ili je jednom pokrenite kao administrator."
```

`intl_messages_ru.arb`:
```json
"updateAvailableTitle": "Доступно обновление",
"updateAvailableBody": "Доступна версия {version}.",
"updateActionUpdate": "Обновить",
"updateActionLater": "Позже",
"updateDownloading": "Загрузка обновления…",
"updateRestartBody": "Обновление загружено. Перезапустите для установки.",
"updateActionRestart": "Перезапуск",
"updateFailedBody": "Не удалось обновить.",
"updateActionClose": "Закрыть",
"updatePermissionBody": "Папка приложения недоступна для записи. Предоставьте разрешение для обновлений.",
"updateActionGrant": "Разрешить",
"updatePermissionFailedBody": "Разрешение не предоставлено. Переместите приложение в доступную для записи папку или запустите его один раз от имени администратора."
```

`intl_messages_zh.arb`:
```json
"updateAvailableTitle": "有可用更新",
"updateAvailableBody": "新版本 {version} 可用。",
"updateActionUpdate": "更新",
"updateActionLater": "稍后",
"updateDownloading": "正在下载更新…",
"updateRestartBody": "更新已下载，重启后生效。",
"updateActionRestart": "重启",
"updateFailedBody": "更新失败。",
"updateActionClose": "关闭",
"updatePermissionBody": "应用文件夹不可写。请授予权限以启用更新。",
"updateActionGrant": "允许",
"updatePermissionFailedBody": "未授予权限。请将应用移至可写文件夹，或以管理员身份运行一次。"
```

(Each file is JSON — mind the comma on the previous last entry.)

- [ ] **Step 5: Regenerate locale Dart files**

```powershell
dart run intl_translation:generate_from_arb --output-dir=lib/src/i18n --no-use-deferred-loading lib/src/i18n/messages.dart lib/src/i18n/intl_messages.arb lib/src/i18n/intl_messages_hr.arb lib/src/i18n/intl_messages_fr.arb lib/src/i18n/intl_messages_nl.arb lib/src/i18n/intl_messages_es.arb lib/src/i18n/intl_messages_ca.arb lib/src/i18n/intl_messages_it.arb lib/src/i18n/intl_messages_zh.arb lib/src/i18n/intl_messages_de.arb lib/src/i18n/intl_messages_ru.arb
```

Expected: `messages_*.dart` regenerated, no errors about the new keys.

- [ ] **Step 6: Verify + commit**

Run: `flutter analyze` (no new — i18n is analyzer-excluded anyway) and `flutter test` (14/14). Then `git diff --stat` — the only large diffs allowed are the regenerated `lib/src/i18n/` files.

```powershell
git add lib/src/i18n
git commit -m "feat(update): localized update-dialog strings in 10 locales"
```

---

### Task 4: UpdateDialog widget (TDD)

**Files:**
- Create: `lib/src/ui/update/update_dialog.dart`
- Test: `test/widget/update_dialog_test.dart`

- [ ] **Step 1: Write the failing tests**

Create `test/widget/update_dialog_test.dart`:

```dart
import 'package:enigma_signal_meter/src/constants.dart';
import 'package:enigma_signal_meter/src/message_provider.dart';
import 'package:enigma_signal_meter/src/model/desktop_updater.dart';
import 'package:enigma_signal_meter/src/ui/update/update_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:version/version.dart';

import '../helpers/fake_desktop_updater.dart';

Widget _harness(Widget dialog) {
  return MaterialApp(
    localizationsDelegates: const [
      SignalMeterLocalizationsDelegate(),
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales:
        languages.map((language) => Locale.fromSubtags(languageCode: language)),
    home: Scaffold(body: dialog),
  );
}

void main() {
  late FakeDesktopUpdater fake;

  setUp(() {
    fake = FakeDesktopUpdater();
    fake.setUpdateAvailable(Version(9, 9, 9));
  });

  UpdateDialog dialog({
    bool writable = true,
    bool grantResult = false,
    bool isMandatory = false,
  }) {
    fake.setUpdateAvailable(Version(9, 9, 9), isMandatory: isMandatory);
    return UpdateDialog(
      updater: fake,
      availability: fake.availability,
      isInstallDirWritable: () async => writable,
      grantInstallDirAccess: () async => grantResult,
    );
  }

  testWidgets('prompt shows version, release notes, Update and Later',
      (tester) async {
    fake.availability = DesktopUpdateAvailability(
      latest: Version(9, 9, 9),
      isMandatory: false,
      releaseNotes: 'feat: shiny new thing',
    );
    await tester.pumpWidget(_harness(UpdateDialog(
      updater: fake,
      availability: fake.availability,
      isInstallDirWritable: () async => true,
      grantInstallDirAccess: () async => false,
    )));
    await tester.pumpAndSettle();

    expect(find.textContaining('9.9.9'), findsOneWidget);
    expect(find.text('feat: shiny new thing'), findsOneWidget);
    expect(find.text('Update'), findsOneWidget);
    expect(find.text('Later'), findsOneWidget);
  });

  testWidgets('mandatory hides Later', (tester) async {
    await tester.pumpWidget(_harness(dialog(isMandatory: true)));
    await tester.pumpAndSettle();

    expect(find.text('Update'), findsOneWidget);
    expect(find.text('Later'), findsNothing);
  });

  testWidgets('non-writable install dir shows Allow instead of Update',
      (tester) async {
    await tester.pumpWidget(_harness(dialog(writable: false)));
    await tester.pumpAndSettle();

    expect(find.text('Allow'), findsOneWidget);
    expect(find.text('Update'), findsNothing);
  });

  testWidgets('failed grant shows the permission-failed line and keeps Allow',
      (tester) async {
    await tester.pumpWidget(
        _harness(dialog(writable: false, grantResult: false)));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Allow'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Permission was not granted'), findsOneWidget);
    expect(find.text('Allow'), findsOneWidget);
  });

  testWidgets('successful grant returns to the normal Update prompt',
      (tester) async {
    await tester
        .pumpWidget(_harness(dialog(writable: false, grantResult: true)));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Allow'));
    await tester.pumpAndSettle();

    expect(find.text('Update'), findsOneWidget);
    expect(find.text('Allow'), findsNothing);
  });

  testWidgets('Update runs to Staged and Restart calls restartAndApply once',
      (tester) async {
    fake.progressEvents = [
      const DesktopUpdateDownloading(0.4),
      DesktopUpdateStaged(Version(9, 9, 9)),
    ];
    await tester.pumpWidget(_harness(dialog()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Update'));
    await tester.pumpAndSettle();

    expect(fake.startUpdateCalls, 1);
    expect(find.textContaining('Restart'), findsWidgets);

    await tester.tap(find.text('Restart'));
    await tester.pumpAndSettle();

    expect(fake.restartAndApplyCalls, 1);
  });

  testWidgets('Failed event shows error state with Close', (tester) async {
    fake.progressEvents = [const DesktopUpdateFailed('boom')];
    await tester.pumpWidget(_harness(dialog()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Update'));
    await tester.pumpAndSettle();

    expect(find.text('Update failed.'), findsOneWidget);
    expect(find.text('Close'), findsOneWidget);
  });
}
```

- [ ] **Step 2: Run tests to verify they fail**

Run: `flutter test test/widget/update_dialog_test.dart`
Expected: FAIL — compilation error, `update_dialog.dart` does not exist.

- [ ] **Step 3: Implement the dialog**

Create `lib/src/ui/update/update_dialog.dart`:

```dart
import 'dart:async';

import 'package:enigma_signal_meter/src/i18n/messages.dart';
import 'package:enigma_signal_meter/src/message_provider.dart';
import 'package:enigma_signal_meter/src/model/desktop_updater.dart';
import 'package:enigma_signal_meter/src/utils/install_dir_access.dart'
    as install_dir_access;
import 'package:flutter/material.dart';

enum _UpdatePhase { prompt, blocked, downloading, restart, error }

/// Self-contained update dialog: prompt → (blocked) → downloading → restart,
/// with an error terminal state. Holds no app state — everything lives here.
class UpdateDialog extends StatefulWidget {
  const UpdateDialog({
    super.key,
    required this.updater,
    required this.availability,
    this.isInstallDirWritable = install_dir_access.isInstallDirWritable,
    this.grantInstallDirAccess = install_dir_access.grantInstallDirAccess,
  });

  final DesktopUpdater updater;
  final DesktopUpdateAvailability availability;
  final Future<bool> Function() isInstallDirWritable;
  final Future<bool> Function() grantInstallDirAccess;

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  _UpdatePhase _phase = _UpdatePhase.prompt;
  bool _grantFailed = false;
  double _progress = 0.0;
  StreamSubscription<DesktopUpdateProgress>? _subscription;

  @override
  void initState() {
    super.initState();
    _checkWritability();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> _checkWritability() async {
    final writable = await widget.isInstallDirWritable();
    if (!mounted) return;
    if (!writable) {
      setState(() => _phase = _UpdatePhase.blocked);
    }
  }

  Future<void> _grant() async {
    final granted = await widget.grantInstallDirAccess();
    if (!mounted) return;
    setState(() {
      if (granted) {
        _phase = _UpdatePhase.prompt;
        _grantFailed = false;
      } else {
        _grantFailed = true;
      }
    });
  }

  void _startUpdate() {
    setState(() {
      _phase = _UpdatePhase.downloading;
      _progress = 0.0;
    });
    _subscription = widget.updater.startUpdate().listen((event) {
      if (!mounted) return;
      setState(() {
        switch (event) {
          case DesktopUpdateDownloading(:final progress):
            _progress = progress;
          case DesktopUpdateStaged():
            _phase = _UpdatePhase.restart;
          case DesktopUpdateFailed():
            _phase = _UpdatePhase.error;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final messages = MessageProvider.of(context);
    final mandatory = widget.availability.isMandatory;

    return PopScope(
      canPop: !mandatory,
      child: AlertDialog(
        title: Text(messages.updateAvailableTitle),
        content: _buildContent(messages),
        actions: _buildActions(messages, mandatory),
      ),
    );
  }

  Widget _buildContent(Messages messages) {
    switch (_phase) {
      case _UpdatePhase.prompt:
      case _UpdatePhase.blocked:
        final version = widget.availability.latest?.toString() ?? '';
        final notes = widget.availability.releaseNotes;
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(messages.updateAvailableBody(version)),
              if (notes != null && notes.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(notes),
              ],
              if (_phase == _UpdatePhase.blocked) ...[
                const SizedBox(height: 12),
                Text(messages.updatePermissionBody),
                if (_grantFailed) ...[
                  const SizedBox(height: 8),
                  Text(messages.updatePermissionFailedBody),
                ],
              ],
            ],
          ),
        );
      case _UpdatePhase.downloading:
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(messages.updateDownloading),
            const SizedBox(height: 12),
            LinearProgressIndicator(value: _progress),
          ],
        );
      case _UpdatePhase.restart:
        return Text(messages.updateRestartBody);
      case _UpdatePhase.error:
        return Text(messages.updateFailedBody);
    }
  }

  List<Widget> _buildActions(Messages messages, bool mandatory) {
    switch (_phase) {
      case _UpdatePhase.prompt:
        return [
          if (!mandatory)
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(messages.updateActionLater),
            ),
          TextButton(
            onPressed: _startUpdate,
            child: Text(messages.updateActionUpdate),
          ),
        ];
      case _UpdatePhase.blocked:
        return [
          if (!mandatory)
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(messages.updateActionLater),
            ),
          TextButton(
            onPressed: _grant,
            child: Text(messages.updateActionGrant),
          ),
        ];
      case _UpdatePhase.downloading:
        return const [];
      case _UpdatePhase.restart:
        return [
          TextButton(
            onPressed: () => widget.updater.restartAndApply(),
            child: Text(messages.updateActionRestart),
          ),
        ];
      case _UpdatePhase.error:
        return [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(messages.updateActionClose),
          ),
        ];
    }
  }
}
```

Note: tests render the dialog inline (not via `showDialog`), so `Navigator.pop` in the error/Later paths runs against the page route — fine in the real app (dialog route) and irrelevant in tests that don't tap those paths against a bare harness. The error-state test only asserts presence of Close, it does not tap it.

- [ ] **Step 4: Run tests to verify they pass**

Run: `flutter test test/widget/update_dialog_test.dart`
Expected: PASS (7 tests).

- [ ] **Step 5: Full verify + commit**

Run: `flutter analyze` (no new) and `flutter test` (21/21).

```powershell
git add lib/src/ui/update/update_dialog.dart test/widget/update_dialog_test.dart
git commit -m "feat(update): update dialog with permission, progress and restart phases"
```

---

### Task 5: update_checker — startup gate (TDD)

**Files:**
- Create: `lib/src/ui/update/update_checker.dart`
- Test: `test/widget/update_checker_test.dart`

- [ ] **Step 1: Write the failing tests**

Create `test/widget/update_checker_test.dart`:

```dart
import 'package:enigma_signal_meter/src/constants.dart';
import 'package:enigma_signal_meter/src/message_provider.dart';
import 'package:enigma_signal_meter/src/ui/update/update_checker.dart';
import 'package:enigma_signal_meter/src/ui/update/update_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:version/version.dart';

import '../helpers/fake_desktop_updater.dart';

Widget _harness(GlobalKey<NavigatorState> navigatorKey) {
  return MaterialApp(
    navigatorKey: navigatorKey,
    localizationsDelegates: const [
      SignalMeterLocalizationsDelegate(),
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales:
        languages.map((language) => Locale.fromSubtags(languageCode: language)),
    home: const Scaffold(body: SizedBox()),
  );
}

void main() {
  late FakeDesktopUpdater fake;
  late GlobalKey<NavigatorState> navigatorKey;

  setUp(() {
    fake = FakeDesktopUpdater();
    navigatorKey = GlobalKey<NavigatorState>();
  });

  Future<void> check(WidgetTester tester, {bool isWindows = true}) async {
    await tester.pumpWidget(_harness(navigatorKey));
    await maybeShowUpdateDialog(
      navigatorKey.currentContext!,
      updater: fake,
      isWindows: isWindows,
      isInstallDirWritable: () async => true,
      grantInstallDirAccess: () async => false,
    );
    await tester.pumpAndSettle();
  }

  testWidgets('shows the dialog when an update is available', (tester) async {
    fake.setUpdateAvailable(Version(9, 9, 9));
    await check(tester);
    expect(find.byType(UpdateDialog), findsOneWidget);
  });

  testWidgets('does nothing when up to date (latest == null)', (tester) async {
    await check(tester);
    expect(find.byType(UpdateDialog), findsNothing);
  });

  testWidgets('does nothing on non-Windows platforms', (tester) async {
    fake.setUpdateAvailable(Version(9, 9, 9));
    await check(tester, isWindows: false);
    expect(fake.checkAvailabilityCalls, 0);
    expect(find.byType(UpdateDialog), findsNothing);
  });

  testWidgets('swallows check failures silently', (tester) async {
    fake.checkError = Exception('offline');
    await check(tester);
    expect(find.byType(UpdateDialog), findsNothing);
  });
}
```

- [ ] **Step 2: Run tests to verify they fail**

Run: `flutter test test/widget/update_checker_test.dart`
Expected: FAIL — compilation error, `update_checker.dart` does not exist.

- [ ] **Step 3: Implement**

Create `lib/src/ui/update/update_checker.dart`:

```dart
import 'dart:async';
import 'dart:io';

import 'package:enigma_signal_meter/src/model/desktop_updater.dart';
import 'package:enigma_signal_meter/src/ui/update/update_dialog.dart';
import 'package:enigma_signal_meter/src/utils/desktop_updater_client.dart';
import 'package:enigma_signal_meter/src/utils/install_dir_access.dart'
    as install_dir_access;
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

final Logger _log = Logger('UpdateChecker');

/// Startup update gate. Windows only; any failure is logged and swallowed —
/// a failed check must never bother the user.
///
/// The plugin already compares the manifest's integer `shortVersion` build
/// number against the running exe, so `latest != null` IS "update available".
Future<void> maybeShowUpdateDialog(
  BuildContext context, {
  DesktopUpdater? updater,
  bool? isWindows,
  Duration timeout = const Duration(seconds: 5),
  Future<bool> Function() isInstallDirWritable =
      install_dir_access.isInstallDirWritable,
  Future<bool> Function() grantInstallDirAccess =
      install_dir_access.grantInstallDirAccess,
}) async {
  if (!(isWindows ?? Platform.isWindows)) {
    return;
  }

  final DesktopUpdateAvailability availability;
  try {
    final effectiveUpdater = updater ?? DesktopUpdaterClient();
    availability = await effectiveUpdater.checkAvailability().timeout(timeout);
    if (availability.latest == null) {
      return;
    }
    if (!context.mounted) {
      return;
    }
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => UpdateDialog(
        updater: effectiveUpdater,
        availability: availability,
        isInstallDirWritable: isInstallDirWritable,
        grantInstallDirAccess: grantInstallDirAccess,
      ),
    );
  } catch (e) {
    _log.fine('Update check skipped: $e');
  }
}
```

Note: this file imports `desktop_updater_client.dart`, which Task 6 creates — **execute Task 6 before Task 5**. The tasks are numbered for reading order (consumer before implementation detail), not execution order.

- [ ] **Step 4: Run tests to verify they pass**

Run: `flutter test test/widget/update_checker_test.dart`
Expected: PASS (4 tests).

- [ ] **Step 5: Full verify + commit**

Run: `flutter analyze` (no new) and `flutter test` (25/25).

```powershell
git add lib/src/ui/update/update_checker.dart test/widget/update_checker_test.dart
git commit -m "feat(update): startup update gate"
```

---

### Task 6: DesktopUpdaterClient + manifest constant

> **Execute BEFORE Task 5** (see note there): Task 5's checker imports this file.

**Files:**
- Create: `lib/src/utils/desktop_updater_client.dart`
- Modify: `lib/src/constants.dart` (append one constant)

- [ ] **Step 1: Append the manifest URL constant**

At the end of `lib/src/constants.dart` (after the `menuIcons` map), add:

```dart
const String appArchiveUrl =
    'https://www.krkadoni.com/signalmeter/app-archive.json';
```

- [ ] **Step 2: Create the client**

Create `lib/src/utils/desktop_updater_client.dart` (BRKO port; the ONLY file importing the plugin):

```dart
import 'dart:async';

import 'package:enigma_signal_meter/src/constants.dart';
import 'package:enigma_signal_meter/src/model/desktop_updater.dart';

// Prefixed so the plugin's DesktopUpdater class does not clash with our
// interface of the same name.
import 'package:desktop_updater/desktop_updater.dart' as du;
import 'package:version/version.dart';

/// Production [DesktopUpdater] backed by the `desktop_updater` plugin.
///
/// Call-sequence contract: [checkAvailability] first (remembers the matched
/// manifest item), then [startUpdate] (downloads + stages, remembers the
/// staging path), then [restartAndApply]. Calling out of order yields a
/// Failed event / StateError rather than undefined behavior.
class DesktopUpdaterClient implements DesktopUpdater {
  DesktopUpdaterClient() : _plugin = du.DesktopUpdater();

  final du.DesktopUpdater _plugin;

  du.ItemModel? _latestItem;
  String? _stagingPath;
  List<String> _removedFiles = const [];

  @override
  Future<DesktopUpdateAvailability> checkAvailability() async {
    _latestItem = null;

    final item = await _plugin.versionCheck(appArchiveUrl: appArchiveUrl);

    if (item == null) {
      return const DesktopUpdateAvailability(latest: null, isMandatory: false);
    }

    _latestItem = item;

    final releaseNotes = item.changes.isNotEmpty
        ? item.changes
            .map((c) => c.type != null ? '${c.type}: ${c.message}' : c.message)
            .join('\n')
        : null;

    return DesktopUpdateAvailability(
      latest: _parseVersion(item.version),
      isMandatory: item.mandatory,
      releaseNotes: releaseNotes,
    );
  }

  @override
  Stream<DesktopUpdateProgress> startUpdate() async* {
    final item = _latestItem;
    if (item == null) {
      yield const DesktopUpdateFailed(
        'startUpdate called before checkAvailability found an update',
      );
      return;
    }

    _stagingPath = null;
    _removedFiles = item.removedFiles;

    Stream<du.UpdateProgress> progressStream;
    try {
      progressStream = await _plugin.updateApp(
        remoteUpdateFolder: item.url,
        changedFiles: item.changedFiles ?? const [],
      );
    } catch (e) {
      yield DesktopUpdateFailed(e.toString());
      return;
    }

    String? lastStagingDir;

    try {
      await for (final event in progressStream) {
        if (event.stagingDirectory != null) {
          lastStagingDir = event.stagingDirectory;
        }
        yield DesktopUpdateDownloading(event.fraction);
      }

      if (lastStagingDir == null || lastStagingDir.isEmpty) {
        yield const DesktopUpdateFailed(
          'Download finished but no staging directory was reported',
        );
        return;
      }

      _stagingPath = lastStagingDir;
      yield DesktopUpdateStaged(_parseVersion(item.version));
    } catch (e) {
      yield DesktopUpdateFailed(e.toString());
    }
  }

  @override
  Future<void> restartAndApply() async {
    final stagingPath = _stagingPath;
    if (stagingPath == null || stagingPath.isEmpty) {
      throw StateError(
        'restartAndApply called before a staged update is ready',
      );
    }

    await _plugin.installUpdate(
      stagingPath: stagingPath,
      removedFiles: _removedFiles,
    );
  }

  Version _parseVersion(String raw) {
    try {
      return Version.parse(raw.trim());
    } catch (_) {
      // Non-semver string (e.g. a bare build number) — degrade gracefully.
      return Version(0, 0, 0, build: raw.trim());
    }
  }
}
```

No automated tests for this file (plugin-backed; the seam consumers are fake-tested, the client is exercised by the manual E2E in Task 8 — same trade-off BRKO made).

- [ ] **Step 3: Verify + commit**

Run: `flutter analyze` (no new items) and `flutter test` (all pass).

```powershell
git add lib/src/constants.dart lib/src/utils/desktop_updater_client.dart
git commit -m "feat(update): plugin-backed desktop updater client"
```

---

### Task 7: Wire into startup + build sanity

**Files:**
- Modify: `lib/src/ui/home/home_view.dart` (initState, ~line 47)

- [ ] **Step 1: Hook the checker into the home view**

In `lib/src/ui/home/home_view.dart` (`dart:io` and `material.dart` are already imported), add the import (alphabetical within the `package:enigma_signal_meter` block):

```dart
import 'package:enigma_signal_meter/src/ui/update/update_checker.dart';
```

Then extend `_HomeViewState.initState`:

```dart
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
```

becomes:

```dart
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    if (Platform.isWindows) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        maybeShowUpdateDialog(context);
      });
    }
  }
```

- [ ] **Step 2: Verify suite + both builds**

Run: `flutter analyze` (no new) and `flutter test` (25/25).
Run: `flutter build windows --debug` then `flutter build apk --debug` (600000 ms timeouts) — the APK build proves `desktop_updater`/`version` don't break mobile compilation.

- [ ] **Step 3: Launch sanity check**

`Start-Process "build\windows\x64\runner\Debug\enigma_signal_meter.exe"`, wait 8 s, confirm `Get-Process enigma_signal_meter` lists it (no update dialog expected — krkadoni.com has no manifest yet, the check fails silently, which is itself a useful fail-open test). `Stop-Process -Name enigma_signal_meter -Confirm:$false`.

- [ ] **Step 4: Commit**

```powershell
git add lib/src/ui/home/home_view.dart
git commit -m "feat(update): check for updates at startup on Windows"
```

---

### Task 8: Manual E2E — real upgrade against a localhost manifest

No file changes are committed by this task (temporary edits are reverted). Largely operator-driven; the human runs the visual parts.

- [ ] **Step 1: Point the app at localhost (temporary)**

In `lib/src/constants.dart`, temporarily change `appArchiveUrl` to `'http://localhost:8080/app-archive.json'`. Do NOT commit.

- [ ] **Step 2: Build the "installed" old version**

```powershell
flutter build windows --release
Copy-Item -Recurse "build\windows\x64\runner\Release" "$env:TEMP\esm-install"
```

Confirm `(Get-Item "$env:TEMP\esm-install\enigma_signal_meter.exe").VersionInfo.ProductVersion` is `1.1.2+5001`.

- [ ] **Step 3: Build the "next" version into dist/**

Temporarily set `version: 1.1.3+5002` in `pubspec.yaml` (do NOT commit), then:

```powershell
if (-not $env:FLUTTER_ROOT) { $env:FLUTTER_ROOT = Split-Path (Split-Path (Get-Command flutter).Source) }
dart run desktop_updater:release windows
dart run desktop_updater:archive windows
```

(The release helper requires `FLUTTER_ROOT`; the first line derives it from the `flutter` on PATH when unset.)

Expected: `dist\5002\1.1.3+5002-windows\` exists and contains `hashes.json` plus the app files.

- [ ] **Step 4: Lay out the server folder + manifest**

```powershell
New-Item -ItemType Directory -Force "$env:TEMP\esm-serve\5002"
Copy-Item -Recurse "dist\5002\1.1.3+5002-windows" "$env:TEMP\esm-serve\5002\windows"
```

Create `$env:TEMP\esm-serve\app-archive.json`:

```json
{
  "appName": "Enigma Signal Meter",
  "description": "Enigma Signal Meter desktop updates",
  "items": [
    {
      "version": "1.1.3",
      "shortVersion": 5002,
      "date": "2026-06-11",
      "mandatory": false,
      "platform": "windows",
      "url": "http://localhost:8080/5002/windows/",
      "changes": [
        { "type": "test", "message": "E2E update test" }
      ]
    }
  ]
}
```

- [ ] **Step 5: Serve and upgrade**

```powershell
dart pub global activate dhttpd
dart pub global run dhttpd --path "$env:TEMP\esm-serve" --port 8080
```

(leave running) — then the human launches `$env:TEMP\esm-install\enigma_signal_meter.exe` and walks the checklist:

- [ ] Update dialog appears showing "1.1.3" and the test release note
- [ ] "Later" closes it and the app works normally (relaunch to get the dialog back)
- [ ] "Update" shows progress, then the Restart state
- [ ] "Restart" exits the app, swaps files, relaunches
- [ ] After relaunch, About screen shows 1.1.3 — and the dialog does NOT reappear (5002 is now current)
- [ ] Optional ACL path: copy the install folder into a protected location (e.g. `C:\Program Files\esm-test`), relaunch, confirm the Allow button + UAC flow grants access and the update applies

- [ ] **Step 6: Revert temporaries**

```powershell
git checkout -- lib/src/constants.dart pubspec.yaml
Remove-Item -Recurse -Force "$env:TEMP\esm-serve", "$env:TEMP\esm-install", "dist"
```

Stop the dhttpd process. `git status --porcelain` must be clean.

---

### Task 9: Docs + final verification

**Files:**
- Create: `docs/windows-release.md`
- Modify: `CHANGES.TXT` (append one bullet)

- [ ] **Step 1: Write the release how-to**

Create `docs/windows-release.md`:

```markdown
# Windows release & auto-update publishing

Every Windows release is published to krkadoni.com so installed apps
self-update. The app reads
`https://www.krkadoni.com/signalmeter/app-archive.json` at startup.

## Steps

1. Bump `version:` in `pubspec.yaml` — the build number after `+` MUST
   increase (it is the integer the updater compares, e.g. `1.1.3+5002`).
2. Build + stage:

   ```powershell
   dart run desktop_updater:release windows
   dart run desktop_updater:archive windows
   ```

   Output: `dist\<build>\<version>+<build>-windows\` containing the app files
   and `hashes.json`.
3. Upload that folder's CONTENTS to
   `https://www.krkadoni.com/signalmeter/<version>/windows/`.
4. Update `app-archive.json` LAST (never advertise a version whose files are
   not uploaded yet). Append an item:

   ```json
   {
     "version": "1.1.3",
     "shortVersion": 5002,
     "date": "2026-06-12",
     "mandatory": false,
     "platform": "windows",
     "url": "https://www.krkadoni.com/signalmeter/1.1.3/windows/",
     "changes": [
       { "type": "feat", "message": "One short English note per change" }
     ]
   }
   ```

   `shortVersion` is the integer build number; `version` is the display
   string. Set `mandatory: true` only to force-block old versions
   (emergency lever — the dialog then has no "Later").

## Server rules

- `app-archive.json`: serve with `Cache-Control: no-cache`.
- Version folders: immutable, long cache is fine.
- Files must be served byte-exact — no CDN compression rewriting or
  transformation; hash verification is byte-exact (Blake2b).
- Keep older version folders online until their user base has moved on; the
  updater always jumps straight to the newest entry.

## Constraint

The app folder on user machines must be user-writable. The app offers a
one-time elevated permission grant when it is not (e.g. under
`C:\Program Files`).
```

- [ ] **Step 2: CHANGES.TXT**

Append to the bullet list:

```text
- Windows app now updates itself automatically
```

- [ ] **Step 3: Final verification**

Run: `flutter analyze` (baseline only), `flutter test` (25/25), `flutter build windows --release` (succeeds).

- [ ] **Step 4: Commit**

```powershell
git add docs/windows-release.md CHANGES.TXT
git commit -m "docs: Windows release and auto-update publishing guide"
```

---

## Out of scope (per spec — do not implement)

Installer/MSIX packaging, macOS/Linux update paths, mid-session polling, auto-restart without a user click, localized release notes, automated release/upload pipeline, first actual upload to krkadoni.com (operator task after merge — follow `docs/windows-release.md`).
