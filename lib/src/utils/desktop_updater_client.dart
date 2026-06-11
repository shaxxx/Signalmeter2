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
    final trimmed = raw.trim();
    try {
      return Version.parse(trimmed);
    } catch (_) {
      // Non-semver string (e.g. a bare build number) — degrade gracefully.
      // Keep only build-legal characters so the fallback cannot itself throw.
      final safe = trimmed.replaceAll(RegExp(r'[^0-9A-Za-z\-.]'), '-');
      return safe.isEmpty ? Version(0, 0, 0) : Version(0, 0, 0, build: safe);
    }
  }
}
