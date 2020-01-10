import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/widgets.dart';

@immutable
class ChangeTtsStatusEvent {
  final TtsStatus status;
  ChangeTtsStatusEvent(this.status) : assert(status != null);
}

@immutable
class ChangeTtsEnabledEvent {
  final bool enable;
  ChangeTtsEnabledEvent(this.enable) : assert(enable != null);
}

@immutable
class SpeakSignalLevelEvent {
  final ISignalResponse response;
  SpeakSignalLevelEvent({
    @required this.response,
  }) : assert(response != null);
}

@immutable
class SpeakSignalLevelSuccessEvent {}

@immutable
class SpeakSignalLevelErrorEvent {
  final dynamic error;
  SpeakSignalLevelErrorEvent(this.error) : assert(error != null);
}

@immutable
class ChangeTtsInitializationStatusEvent {
  final TtsInitializationStatus status;
  ChangeTtsInitializationStatusEvent(this.status) : assert(status != null);
}

@immutable
class InitializeTtsEvent {}

@immutable
class InitializeTtsSuccessEvent {}

@immutable
class InitializeTtsErrorEvent {
  final dynamic error;
  InitializeTtsErrorEvent(this.error) : assert(error != null);
}
