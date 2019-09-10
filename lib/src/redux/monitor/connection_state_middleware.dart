import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/enigma/enigma_command_events.dart';
import 'package:redux/redux.dart';

import 'connection_state_events.dart';

class ConnectionStateMiddleware extends MiddlewareClass<AppState> {
  ConnectionStateMiddleware();

  @override
  void call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is EnigmaCommandErrorEvent) {
      store.dispatch(
          ConnectionStatusChangedEvent(ConnectionStatusEnum.disconnected));
    } else if (action is WakeUpSuccessEvent) {
      store.dispatch(
        ConnectionStatusChangedEvent(ConnectionStatusEnum.connected),
      );
    } else if (action is SentToSleepSuccessEvent) {
      store.dispatch(
        ConnectionStatusChangedEvent(ConnectionStatusEnum.disconnected),
      );
    } else if (action is RestartSuccessEvent) {
      store.dispatch(
        ConnectionStatusChangedEvent(ConnectionStatusEnum.disconnected),
      );
    } else if (action is WakeUpEvent) {
      store.dispatch(
        ConnectionStatusChangedEvent(ConnectionStatusEnum.connecting),
      );
    } else if (action is SentToSleepEvent) {
      store.dispatch(
        ConnectionStatusChangedEvent(ConnectionStatusEnum.disconnecting),
      );
    } else if (action is RestartEvent) {
      store.dispatch(
        ConnectionStatusChangedEvent(ConnectionStatusEnum.disconnecting),
      );
    }
    next(action);
  }
}
