import 'package:enigma_signal_meter/src/model/enigma_web_exception.dart';
import 'package:enigma_signal_meter/src/redux/enigma/enigma_command_events.dart';
import 'package:enigma_signal_meter/src/utils/stream_manager.dart';
import 'package:flutter/widgets.dart';

import 'message_event.dart';

@immutable
abstract class ErrorMessageEvent<T> extends MessageEvent {
  T get exception;
}

@immutable
class ErrorMessageShownEvent {
  final ErrorMessageEvent errorMessageEvent;
  ErrorMessageShownEvent(this.errorMessageEvent)
      : assert(
          errorMessageEvent != null,
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ErrorMessageShownEvent &&
          runtimeType == other.runtimeType &&
          errorMessageEvent == other.errorMessageEvent;

  @override
  int get hashCode => errorMessageEvent.hashCode;
}

@immutable
class EnigmaCommandErrorMessageEvent
    extends ErrorMessageEvent<EnigmaWebException> {
  final EnigmaCommandErrorEvent action;
  @override
  final EnigmaWebException exception;

  EnigmaCommandErrorMessageEvent({
    @required this.action,
    @required this.exception,
  })  : assert(action != null),
        assert(exception != null);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnigmaCommandErrorMessageEvent &&
          runtimeType == other.runtimeType &&
          action == other.action &&
          exception == other.exception;

  @override
  int get hashCode => action.hashCode ^ exception.hashCode;
}

@immutable
class FailedStreamExtraParametersMessageEvent
    extends ErrorMessageEvent<EnigmaWebException> {
  final StreamParametersResponse response;
  @override
  final EnigmaWebException exception;
  FailedStreamExtraParametersMessageEvent({
    @required this.response,
    @required this.exception,
  })  : assert(response != null),
        assert(exception != null);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FailedStreamExtraParametersMessageEvent &&
          runtimeType == other.runtimeType &&
          exception == other.exception &&
          response == other.response;

  @override
  int get hashCode => exception.hashCode ^ response.hashCode;
}

@immutable
class UnhandledErrorMessageEvent extends ErrorMessageEvent<dynamic> {
  @override
  final dynamic exception;

  UnhandledErrorMessageEvent({
    @required this.exception,
  }) : assert(exception != null);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnigmaCommandErrorMessageEvent &&
          runtimeType == other.runtimeType &&
          exception == other.exception;

  @override
  int get hashCode => exception.hashCode;
}
