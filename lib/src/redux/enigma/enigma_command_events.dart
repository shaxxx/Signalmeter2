import 'package:enigma_signal_meter/src/model/enigma_web_exception.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/cupertino.dart';

abstract class EnigmaCommandEvent {
  final IProfile profile;
  DateTime startTime;
  EnigmaCommandEvent({
    @required this.profile,
  }) : assert(profile != null) {
    startTime = DateTime.now();
  }
}

@immutable
abstract class EnigmaCommandSuccessEvent {
  final Duration responseDuration;
  EnigmaCommandSuccessEvent({
    @required this.responseDuration,
  });
}

@immutable
abstract class EnigmaCommandErrorEvent {
  final EnigmaWebException error;
  final IProfile profile;
  EnigmaCommandErrorEvent({
    @required this.error,
    @required this.profile,
  })  : assert(error != null),
        assert(
          profile != null,
        );
}

class GetCurrentServiceEvent extends EnigmaCommandEvent {
  GetCurrentServiceEvent({
    @required IProfile profile,
  }) : super(profile: profile);
}

@immutable
class GetCurrentServiceErrorEvent extends EnigmaCommandErrorEvent {
  GetCurrentServiceErrorEvent({
    @required EnigmaWebException error,
    @required IProfile profile,
  }) : super(
          error: error,
          profile: profile,
        );
}

@immutable
class GetCurrentServiceSuccessEvent extends EnigmaCommandSuccessEvent {
  final IGetCurrentServiceResponse response;
  GetCurrentServiceSuccessEvent({
    @required Duration responseDuration,
    @required this.response,
  }) : super(responseDuration: responseDuration);
}

class GetSignalLevelEvent extends EnigmaCommandEvent {
  GetSignalLevelEvent({
    @required IProfile profile,
  }) : super(profile: profile);
}

@immutable
class GetSignalLevelErrorEvent extends EnigmaCommandErrorEvent {
  GetSignalLevelErrorEvent({
    @required EnigmaWebException error,
    @required IProfile profile,
  }) : super(
          error: error,
          profile: profile,
        );
}

@immutable
class GetSignalLevelSuccessEvent extends EnigmaCommandSuccessEvent {
  final ISignalResponse response;
  GetSignalLevelSuccessEvent({
    @required Duration responseDuration,
    @required this.response,
  })  : assert(response != null),
        super(responseDuration: responseDuration);
}

class ChangeServiceEvent extends EnigmaCommandEvent {
  final IBouquetItemService service;
  ChangeServiceEvent({
    @required IProfile profile,
    @required this.service,
  }) : super(profile: profile);
}

@immutable
class ChangeServiceErrorEvent extends EnigmaCommandErrorEvent {
  final IBouquetItemService service;
  ChangeServiceErrorEvent({
    @required EnigmaWebException error,
    @required IProfile profile,
    @required this.service,
  }) : super(
          error: error,
          profile: profile,
        );
}

@immutable
class ChangeServiceSuccessEvent extends EnigmaCommandSuccessEvent {
  final IBouquetItemService service;
  ChangeServiceSuccessEvent({
    @required Duration responseDuration,
    @required this.service,
  }) : super(responseDuration: responseDuration);
}

class GetBouquetItemsEvent extends EnigmaCommandEvent {
  final IBouquetItemBouquet bouquet;
  @override
  final IProfile profile;
  GetBouquetItemsEvent({
    @required this.profile,
    @required this.bouquet,
  })  : assert(bouquet != null),
        assert(profile != null),
        super(profile: profile);
}

@immutable
class GetBouquetItemsErrorEvent extends EnigmaCommandErrorEvent {
  GetBouquetItemsErrorEvent({
    @required IBouquetItemBouquet bouquet,
    @required EnigmaWebException error,
    @required IProfile profile,
  })  : assert(bouquet != null),
        super(
          error: error,
          profile: profile,
        );
}

@immutable
class GetBouquetItemsSuccessEvent extends EnigmaCommandSuccessEvent {
  final BouquetItemBouquet bouquet;
  final List<IBouquetItem> bouquetItems;
  GetBouquetItemsSuccessEvent({
    @required this.bouquet,
    @required this.bouquetItems,
    @required Duration responseDuration,
  })  : assert(bouquet != null),
        assert(bouquetItems != null),
        super(responseDuration: responseDuration);
}

class GetBouquetsEvent extends EnigmaCommandEvent {
  GetBouquetsEvent({
    @required IProfile profile,
  }) : super(profile: profile);
}

@immutable
class GetBouquetsErrorEvent extends EnigmaCommandErrorEvent {
  GetBouquetsErrorEvent({
    @required EnigmaWebException error,
    @required IProfile profile,
  }) : super(
          error: error,
          profile: profile,
        );
}

@immutable
class GetBouquetsSuccessEvent extends EnigmaCommandSuccessEvent {
  final List<IBouquetItemBouquet> bouquets;
  GetBouquetsSuccessEvent({
    @required this.bouquets,
    @required Duration responseDuration,
  })  : assert(bouquets != null),
        super(responseDuration: responseDuration);
}

class GetStreamParametersEvent extends EnigmaCommandEvent {
  final IBouquetItemService service;
  GetStreamParametersEvent({
    @required IProfile profile,
    @required this.service,
  })  : assert(profile != null),
        assert(service != null),
        super(profile: profile);
}

@immutable
class GetStreamParametersErrorEvent extends EnigmaCommandErrorEvent {
  final IBouquetItemService service;
  GetStreamParametersErrorEvent({
    @required EnigmaWebException error,
    @required this.service,
    @required IProfile profile,
  })  : assert(error != null),
        assert(service != null),
        super(
          error: error,
          profile: profile,
        );
}

@immutable
class GetStreamParametersSuccessEvent extends EnigmaCommandSuccessEvent {
  final IBouquetItemService service;
  GetStreamParametersSuccessEvent({
    @required Duration responseDuration,
    @required this.service,
  })  : assert(service != null),
        super(responseDuration: responseDuration);
}

class GetScreenShotOfCurrentServiceEvent extends EnigmaCommandEvent {
  final ScreenshotType screenshotType;
  GetScreenShotOfCurrentServiceEvent({
    @required IProfile profile,
    @required this.screenshotType,
  }) : super(profile: profile);
}

@immutable
class GetScreenShotOfCurrentServiceErrorEvent extends EnigmaCommandErrorEvent {
  GetScreenShotOfCurrentServiceErrorEvent({
    @required EnigmaWebException error,
    @required IProfile profile,
  }) : super(
          error: error,
          profile: profile,
        );
}

@immutable
class GetScreenShotOfCurrentServiceSuccessEvent
    extends EnigmaCommandSuccessEvent {
  final ScreenshotResponse response;
  GetScreenShotOfCurrentServiceSuccessEvent({
    @required Duration responseDuration,
    @required this.response,
  }) : super(responseDuration: responseDuration);
}

class SentToSleepEvent extends EnigmaCommandEvent {
  SentToSleepEvent({
    @required IProfile profile,
  }) : super(profile: profile);
}

@immutable
class SentToSleepErrorEvent extends EnigmaCommandErrorEvent {
  SentToSleepErrorEvent({
    @required EnigmaWebException error,
    @required IProfile profile,
  }) : super(error: error, profile: profile);
}

@immutable
class SentToSleepSuccessEvent extends EnigmaCommandSuccessEvent {
  SentToSleepSuccessEvent({
    @required Duration responseDuration,
  }) : super(responseDuration: responseDuration);
}

class RestartEvent extends EnigmaCommandEvent {
  RestartEvent({
    @required IProfile profile,
  }) : super(profile: profile);
}

@immutable
class RestartErrorEvent extends EnigmaCommandErrorEvent {
  RestartErrorEvent({
    @required EnigmaWebException error,
    @required IProfile profile,
  }) : super(
          error: error,
          profile: profile,
        );
}

@immutable
class RestartSuccessEvent extends EnigmaCommandSuccessEvent {
  RestartSuccessEvent({
    @required Duration responseDuration,
  }) : super(responseDuration: responseDuration);
}

class WakeUpEvent extends EnigmaCommandEvent {
  WakeUpEvent({
    @required IProfile profile,
  }) : super(profile: profile);
}

@immutable
class WakeUpErrorEvent extends EnigmaCommandErrorEvent {
  WakeUpErrorEvent({
    @required EnigmaWebException error,
    @required IProfile profile,
  }) : super(
          error: error,
          profile: profile,
        );
}

@immutable
class WakeUpSuccessEvent extends EnigmaCommandSuccessEvent {
  WakeUpSuccessEvent({
    @required Duration responseDuration,
  }) : super(responseDuration: responseDuration);
}

class SendRemoteControlCodeEvent extends EnigmaCommandEvent {
  final RemoteControlCode code;
  SendRemoteControlCodeEvent({
    @required IProfile profile,
    @required this.code,
  }) : super(profile: profile);
}

@immutable
class SendRemoteControlCodeSuccessEvent extends EnigmaCommandSuccessEvent {
  SendRemoteControlCodeSuccessEvent({
    @required Duration responseDuration,
  }) : super(responseDuration: responseDuration);
}

@immutable
class SendRemoteControlCodeErrorEvent extends EnigmaCommandErrorEvent {
  final RemoteControlCode code;
  SendRemoteControlCodeErrorEvent({
    @required EnigmaWebException error,
    @required IProfile profile,
    @required this.code,
  }) : super(
          error: error,
          profile: profile,
        );
}
