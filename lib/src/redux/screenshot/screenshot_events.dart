import 'package:enigma_signal_meter/src/model/enums.dart';

import 'package:flutter/widgets.dart';

@immutable
class ScreenshotStatusChangedEvent {
  final LoadingStatus status;
  ScreenshotStatusChangedEvent(this.status) : assert(status != null);
}
