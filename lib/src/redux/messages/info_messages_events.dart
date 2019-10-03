import 'package:flutter/widgets.dart';

import 'message_event.dart';

@immutable
abstract class InfoMessageEvent extends MessageEvent {}

@immutable
class InfoMessageShownEvent {
  final InfoMessageEvent infoMessageEvent;
  InfoMessageShownEvent(this.infoMessageEvent)
      : assert(
          infoMessageEvent != null,
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InfoMessageShownEvent &&
          runtimeType == other.runtimeType &&
          infoMessageEvent == other.infoMessageEvent;

  @override
  int get hashCode => infoMessageEvent.hashCode;
}

@immutable
class InitializingStreamMessageEvent extends InfoMessageEvent {}

@immutable
class TestInfoMessageEvent extends InfoMessageEvent {}

@immutable
class CheckingPortsInfoMessageEvent extends InfoMessageEvent {}

@immutable
class ScreenshotSavedInfoMessageEvent extends InfoMessageEvent {}
