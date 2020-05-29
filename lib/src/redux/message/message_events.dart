import 'package:enigma_signal_meter/src/model/enums.dart';

import 'package:flutter/widgets.dart';

@immutable
class SendMessageStatusChangedEvent {
  final LoadingStatus status;
  SendMessageStatusChangedEvent(this.status) : assert(status != null);
}
