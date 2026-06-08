import 'package:enigma_signal_meter/src/model/enigma_web_exception.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/cupertino.dart';

abstract class EnigmaCommandEvent {
  final IProfile profile;
  late DateTime startTime;
  EnigmaCommandEvent({
    required this.profile,
  }) {
    startTime = DateTime.now();
  }
}

@immutable
abstract class EnigmaCommandSuccessEvent {
  final Duration responseDuration;
  const EnigmaCommandSuccessEvent({
    required this.responseDuration,
  });
}

@immutable
abstract class EnigmaCommandErrorEvent {
  final EnigmaWebException error;
  final IProfile profile;
  const EnigmaCommandErrorEvent({
    required this.error,
    required this.profile,
  });
}

class GetCurrentServiceEvent extends EnigmaCommandEvent {
  GetCurrentServiceEvent({
    required super.profile,
  });
}

@immutable
class GetCurrentServiceErrorEvent extends EnigmaCommandErrorEvent {
  const GetCurrentServiceErrorEvent({
    required super.error,
    required super.profile,
  });
}

@immutable
class GetCurrentServiceSuccessEvent extends EnigmaCommandSuccessEvent {
  final IGetCurrentServiceResponse response;
  const GetCurrentServiceSuccessEvent({
    required super.responseDuration,
    required this.response,
  });
}

class GetSignalLevelEvent extends EnigmaCommandEvent {
  GetSignalLevelEvent({
    required super.profile,
  });
}

@immutable
class GetSignalLevelErrorEvent extends EnigmaCommandErrorEvent {
  const GetSignalLevelErrorEvent({
    required super.error,
    required super.profile,
  });
}

@immutable
class GetSignalLevelSuccessEvent extends EnigmaCommandSuccessEvent {
  final ISignalResponse response;
  const GetSignalLevelSuccessEvent({
    required super.responseDuration,
    required this.response,
  });
}

class ChangeServiceEvent extends EnigmaCommandEvent {
  final IBouquetItemService service;
  ChangeServiceEvent({
    required super.profile,
    required this.service,
  });
}

@immutable
class ChangeServiceErrorEvent extends EnigmaCommandErrorEvent {
  final IBouquetItemService service;
  const ChangeServiceErrorEvent({
    required super.error,
    required super.profile,
    required this.service,
  });
}

@immutable
class ChangeServiceSuccessEvent extends EnigmaCommandSuccessEvent {
  final IBouquetItemService service;
  const ChangeServiceSuccessEvent({
    required super.responseDuration,
    required this.service,
  });
}

class GetBouquetItemsEvent extends EnigmaCommandEvent {
  final IBouquetItemBouquet bouquet;
  @override
  final IProfile profile;
  GetBouquetItemsEvent({
    required this.profile,
    required this.bouquet,
  })  : super(profile: profile);
}

@immutable
class GetBouquetItemsErrorEvent extends EnigmaCommandErrorEvent {
  const GetBouquetItemsErrorEvent({
    required IBouquetItemBouquet bouquet,
    required super.error,
    required super.profile,
  });
}

@immutable
class GetBouquetItemsSuccessEvent extends EnigmaCommandSuccessEvent {
  final IBouquetItemBouquet bouquet;
  final List<IBouquetItem> bouquetItems;
  const GetBouquetItemsSuccessEvent({
    required this.bouquet,
    required this.bouquetItems,
    required super.responseDuration,
  });
}

class GetBouquetsEvent extends EnigmaCommandEvent {
  GetBouquetsEvent({
    required super.profile,
  });
}

@immutable
class GetBouquetsErrorEvent extends EnigmaCommandErrorEvent {
  const GetBouquetsErrorEvent({
    required super.error,
    required super.profile,
  });
}

@immutable
class GetBouquetsSuccessEvent extends EnigmaCommandSuccessEvent {
  final List<IBouquetItemBouquet> bouquets;
  const GetBouquetsSuccessEvent({
    required this.bouquets,
    required super.responseDuration,
  });
}

class GetStreamParametersEvent extends EnigmaCommandEvent {
  final IBouquetItemService service;
  GetStreamParametersEvent({
    required super.profile,
    required this.service,
  });
}

@immutable
class GetStreamParametersErrorEvent extends EnigmaCommandErrorEvent {
  final IBouquetItemService service;
  const GetStreamParametersErrorEvent({
    required super.error,
    required this.service,
    required super.profile,
  });
}

@immutable
class GetStreamParametersSuccessEvent extends EnigmaCommandSuccessEvent {
  final IBouquetItemService service;
  const GetStreamParametersSuccessEvent({
    required super.responseDuration,
    required this.service,
  });
}

class GetScreenShotOfCurrentServiceEvent extends EnigmaCommandEvent {
  final ScreenshotType screenshotType;
  GetScreenShotOfCurrentServiceEvent({
    required super.profile,
    required this.screenshotType,
  });
}

@immutable
class GetScreenShotOfCurrentServiceErrorEvent extends EnigmaCommandErrorEvent {
  const GetScreenShotOfCurrentServiceErrorEvent({
    required super.error,
    required super.profile,
  });
}

@immutable
class GetScreenShotOfCurrentServiceSuccessEvent
    extends EnigmaCommandSuccessEvent {
  final IScreenshotResponse response;
  const GetScreenShotOfCurrentServiceSuccessEvent({
    required super.responseDuration,
    required this.response,
  });
}

class SentToSleepEvent extends EnigmaCommandEvent {
  SentToSleepEvent({
    required super.profile,
  });
}

@immutable
class SentToSleepErrorEvent extends EnigmaCommandErrorEvent {
  const SentToSleepErrorEvent({
    required super.error,
    required super.profile,
  });
}

@immutable
class SentToSleepSuccessEvent extends EnigmaCommandSuccessEvent {
  const SentToSleepSuccessEvent({
    required super.responseDuration,
  });
}

class RestartEvent extends EnigmaCommandEvent {
  RestartEvent({
    required super.profile,
  });
}

@immutable
class RestartErrorEvent extends EnigmaCommandErrorEvent {
  const RestartErrorEvent({
    required super.error,
    required super.profile,
  });
}

@immutable
class RestartSuccessEvent extends EnigmaCommandSuccessEvent {
  const RestartSuccessEvent({
    required super.responseDuration,
  });
}

class WakeUpEvent extends EnigmaCommandEvent {
  WakeUpEvent({
    required super.profile,
  });
}

@immutable
class WakeUpErrorEvent extends EnigmaCommandErrorEvent {
  const WakeUpErrorEvent({
    required super.error,
    required super.profile,
  });
}

@immutable
class WakeUpSuccessEvent extends EnigmaCommandSuccessEvent {
  const WakeUpSuccessEvent({
    required super.responseDuration,
  });
}

class SendRemoteControlCodeEvent extends EnigmaCommandEvent {
  final RemoteControlCode code;
  SendRemoteControlCodeEvent({
    required super.profile,
    required this.code,
  });
}

@immutable
class SendRemoteControlCodeSuccessEvent extends EnigmaCommandSuccessEvent {
  const SendRemoteControlCodeSuccessEvent({
    required super.responseDuration,
  });
}

@immutable
class SendRemoteControlCodeErrorEvent extends EnigmaCommandErrorEvent {
  final RemoteControlCode code;
  const SendRemoteControlCodeErrorEvent({
    required super.error,
    required super.profile,
    required this.code,
  });
}

class SendMessageEvent extends EnigmaCommandEvent {
  final String message;
  final Duration timeout;
  final MessageType messageType;
  SendMessageEvent({
    required super.profile,
    required this.message,
    required this.timeout,
    required this.messageType,
  });
}

@immutable
class SendMessageErrorEvent extends EnigmaCommandErrorEvent {
  const SendMessageErrorEvent({
    required super.error,
    required super.profile,
  });
}

@immutable
class SendMessageSuccessEvent extends EnigmaCommandSuccessEvent {
  const SendMessageSuccessEvent({
    required super.responseDuration,
  });
}
