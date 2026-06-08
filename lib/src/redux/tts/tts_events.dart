import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/widgets.dart';

@immutable
class ChangeTtsStatusEvent {
  final TtsStatus status;
  const ChangeTtsStatusEvent(this.status);
}

@immutable
class ChangeTtsEnabledEvent {
  final bool enable;
  const ChangeTtsEnabledEvent(this.enable);
}

@immutable
class SpeakSignalLevelEvent {
  final ISignalResponse response;
  const SpeakSignalLevelEvent({
    required this.response,
  });
}

@immutable
class SpeakSignalLevelSuccessEvent {}

@immutable
class SpeakSignalLevelErrorEvent {
  final dynamic error;
  const SpeakSignalLevelErrorEvent(this.error) : assert(error != null);
}

@immutable
class ChangeTtsInitializationStatusEvent {
  final TtsInitializationStatus status;
  const ChangeTtsInitializationStatusEvent(this.status);
}

@immutable
class InitializeTtsEvent {}

@immutable
class InitializeTtsSuccessEvent {}

@immutable
class InitializeTtsErrorEvent {
  final dynamic error;
  const InitializeTtsErrorEvent(this.error) : assert(error != null);
}
