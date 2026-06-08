import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/widgets.dart';

@immutable
class ChangeTtsStatusEvent {
  final TtsStatus status;
  ChangeTtsStatusEvent(this.status);
}

@immutable
class ChangeTtsEnabledEvent {
  final bool enable;
  ChangeTtsEnabledEvent(this.enable);
}

@immutable
class SpeakSignalLevelEvent {
  final ISignalResponse response;
  SpeakSignalLevelEvent({
    @required this.response,
  });
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
  ChangeTtsInitializationStatusEvent(this.status);
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
