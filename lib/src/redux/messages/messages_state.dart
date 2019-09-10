import 'package:flutter/widgets.dart';
import 'package:collection/collection.dart';

import 'error_messages_events.dart';
import 'info_messages_events.dart';
import 'warning_messages_events.dart';

class MessagesState {
  final List<InfoMessageEvent> infoMessages;
  final List<ErrorMessageEvent> errorMessages;
  final List<WarningMessageEvent> warningMessages;

  MessagesState({
    @required this.infoMessages,
    @required this.errorMessages,
    @required this.warningMessages,
  })  : assert(infoMessages != null),
        assert(errorMessages != null),
        assert(warningMessages != null);

  static MessagesState initial() {
    return MessagesState(
      infoMessages: List<InfoMessageEvent>(),
      errorMessages: List<ErrorMessageEvent>(),
      warningMessages: List<WarningMessageEvent>(),
    );
  }

  MessagesState copyWith({
    List<InfoMessageEvent> infoMessages,
    List<ErrorMessageEvent> errorMessages,
    List<WarningMessageEvent> warningMessages,
  }) {
    return MessagesState(
      errorMessages: errorMessages ?? this.errorMessages,
      infoMessages: infoMessages ?? this.infoMessages,
      warningMessages: warningMessages ?? this.warningMessages,
    );
  }

  @override
  int get hashCode =>
      const IterableEquality().hash(errorMessages) ^
      const IterableEquality().hash(infoMessages) ^
      const IterableEquality().hash(warningMessages);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessagesState &&
          runtimeType == other.runtimeType &&
          const IterableEquality().equals(errorMessages, other.errorMessages) &&
          const IterableEquality().equals(infoMessages, other.infoMessages) &&
          const IterableEquality()
              .equals(warningMessages, other.warningMessages);
}
