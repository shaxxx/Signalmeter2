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
