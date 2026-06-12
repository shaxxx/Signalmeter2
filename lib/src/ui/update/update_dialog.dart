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
    // First frame intentionally renders the prompt phase; the async probe
    // flips to blocked only when needed (sub-frame for a local filesystem
    // probe). Do not make this synchronous.
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

  Future<void> _restart() async {
    try {
      await widget.updater.restartAndApply();
    } catch (_) {
      // On success the app exits; reaching here means the apply failed.
      if (!mounted) return;
      setState(() => _phase = _UpdatePhase.error);
    }
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
      // Escape/back must not orphan an in-flight download; the plugin's
      // download is not cancellable through the seam.
      canPop: !mandatory && _phase != _UpdatePhase.downloading,
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
            onPressed: _restart,
            child: Text(messages.updateActionRestart),
          ),
        ];
      case _UpdatePhase.error:
        return [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(messages.close),
          ),
        ];
    }
  }
}
