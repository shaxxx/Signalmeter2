import 'package:enigma_signal_meter/src/model/enums.dart';

import 'package:flutter/widgets.dart';

@immutable
class ScreenshotStatusChangedEvent {
  final LoadingStatus status;
  const ScreenshotStatusChangedEvent(this.status);
}
