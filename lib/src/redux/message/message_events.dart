import 'package:enigma_signal_meter/src/model/enums.dart';

import 'package:flutter/widgets.dart';

@immutable
class SendMessageStatusChangedEvent {
  final LoadingStatus status;
  const SendMessageStatusChangedEvent(this.status);
}
