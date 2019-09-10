import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:flutter/foundation.dart';

@immutable
class ChangeCurrentServiceMonitorStatusEvent {
  final MonitorStatus status;
  ChangeCurrentServiceMonitorStatusEvent(this.status);
}
