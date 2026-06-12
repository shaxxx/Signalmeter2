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
  // Apostrophes would terminate the single-quoted PowerShell string below;
  // '' is PowerShell's escape for a literal ' inside one.
  final escapedDir = dir.replaceAll("'", "''");
  final escapedUser = user.replaceAll("'", "''");
  try {
    final process = await Process.start('powershell', [
      '-NoProfile',
      '-Command',
      // (OI)(CI) = object + container inherit, so the Modify grant reaches
      // existing and future files in the install folder.
      'Start-Process icacls -Verb RunAs -Wait -ArgumentList '
          '\'"$escapedDir" /grant "$escapedUser":(OI)(CI)M\'',
    ]);
    await process.exitCode;
  } catch (e) {
    _log.warning('Elevated icacls launch failed: $e');
  }
  return isInstallDirWritable();
}
