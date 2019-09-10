import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:flutter/widgets.dart';

@immutable
class ChangeSignalMonitorStatusEvent {
  final MonitorStatus status;
  ChangeSignalMonitorStatusEvent(this.status);
}
