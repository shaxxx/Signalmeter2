import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/enigma/enigma_command_events.dart';
import 'package:enigma_signal_meter/src/redux/messages/warning_messages_events.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';

class MessageViewModel {
  final VoidCallback displayFormInvalidWarningMessage;
  final void Function(String, Duration, MessageType) onSendMessage;
  final LoadingStatus status;

  MessageViewModel({
    @required this.displayFormInvalidWarningMessage,
    @required this.onSendMessage,
    @required this.status,
  });

  static MessageViewModel fromStore(Store<AppState> store) {
    return MessageViewModel(
        displayFormInvalidWarningMessage: () {
          store.dispatch(
            FormInvalidMessageEvent(),
          );
        },
        onSendMessage: (message, timeout, messageType) {
          store.dispatch(
            SendMessageEvent(
              profile: store.state.profilesState.selectedProfile,
              message: message,
              timeout: timeout,
              messageType: messageType,
            ),
          );
        },
        status: store.state.messageState.status);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageViewModel &&
          runtimeType == other.runtimeType &&
          status == other.status;

  @override
  int get hashCode => status.hashCode;
}
