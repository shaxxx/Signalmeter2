import 'package:flutter/widgets.dart';

import 'message_event.dart';

@immutable
abstract class WarningMessageEvent extends MessageEvent {}

@immutable
class WarningMessageShownEvent {
  final WarningMessageEvent warningMessageEvent;
  WarningMessageShownEvent(this.warningMessageEvent)
      : assert(
          warningMessageEvent != null,
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WarningMessageShownEvent &&
          runtimeType == other.runtimeType &&
          warningMessageEvent == other.warningMessageEvent;

  @override
  int get hashCode => warningMessageEvent.hashCode;
}

@immutable
class FailedStreamPortMessageEvent extends WarningMessageEvent {}

@immutable
class UnsupportedPlatformMessageEvent extends WarningMessageEvent {
  final String platform;

  UnsupportedPlatformMessageEvent({
    @required this.platform,
  }) : assert(platform != null);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UnsupportedPlatformMessageEvent &&
          runtimeType == other.runtimeType &&
          platform == other.platform;

  @override
  int get hashCode => platform.hashCode;
}

class TtsInitFailedMessageEvent extends WarningMessageEvent {
  final dynamic error;

  TtsInitFailedMessageEvent(this.error);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TtsInitFailedMessageEvent &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}

class TtsSpeakFailedMessageEvent extends WarningMessageEvent {
  final dynamic error;

  TtsSpeakFailedMessageEvent(this.error);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TtsSpeakFailedMessageEvent &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}

@immutable
class VlcRequiredMessageEvent extends WarningMessageEvent {}

@immutable
class FormInvalidMessageEvent extends WarningMessageEvent {}
