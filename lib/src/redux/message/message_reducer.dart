import 'package:enigma_signal_meter/src/redux/monitor/connection_state_events.dart';
import 'package:redux/redux.dart';

import 'message_state.dart';
import 'message_events.dart';

final messageReducer = combineReducers<MessageState>([
  TypedReducer<MessageState, SendMessageStatusChangedEvent>(
      _messageStatusChangedReducer),
  TypedReducer<MessageState, ResetStateEvent>(_MessageStateResetReducer),
]);

MessageState _messageStatusChangedReducer(
    MessageState state, SendMessageStatusChangedEvent event) {
  return state.copyWith(status: event.status);
}

MessageState _MessageStateResetReducer(
    MessageState state, ResetStateEvent event) {
  return MessageState.initial();
}
