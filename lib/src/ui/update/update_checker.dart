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
    // Scheduled, not awaited: showDialog's future resolves only when the
    // dialog pops, and this gate has nothing left to do once it is shown.
    unawaited(showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => UpdateDialog(
        updater: effectiveUpdater,
        availability: availability,
        isInstallDirWritable: isInstallDirWritable,
        grantInstallDirAccess: grantInstallDirAccess,
      ),
    ));
  } catch (e) {
    _log.fine('Update check skipped: $e');
  }
}
