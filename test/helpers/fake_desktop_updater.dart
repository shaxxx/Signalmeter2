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
