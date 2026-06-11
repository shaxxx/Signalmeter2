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
