import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:logging/logging.dart';

import 'package:redux/redux.dart';

import 'connection_state_events.dart';

final connectionStateReducer = combineReducers<ConnectionStatusEnum>([
  TypedReducer<ConnectionStatusEnum, ConnectionStatusChangedEvent>(
      (curentState, event) {
    Logger.root.fine('Connection state set to ${event.status.toString()}');
    return event.status;
  }),
  TypedReducer<ConnectionStatusEnum, ResetStateEvent>((curentState, event) {
    Logger.root.fine('Reseting connection state');
    return ConnectionStatusEnum.disconnected;
  }),
]);
