import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/enigma/enigma_command_events.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';

import 'message_events.dart';

class MessageMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is SendMessageErrorEvent) {
      Logger.root.fine(
          'Dispatching MessageStatusChangedEvent from MessageMiddleware as response to SendMessageErrorEvent');
      store.dispatch(SendMessageStatusChangedEvent(LoadingStatus.error));
    } else if (action is SendMessageSuccessEvent) {
      Logger.root.fine(
          'Dispatching MessageStatusChangedEvent from MessageMiddleware as response to SendMessageSuccessEvent');
      store.dispatch(SendMessageStatusChangedEvent(LoadingStatus.success));
    } else if (action is SendMessageEvent) {
      Logger.root.fine(
          'Dispatching MessageStatusChangedEvent from MessageMiddleware as response to SendMessageEvent');
      store.dispatch(SendMessageStatusChangedEvent(LoadingStatus.loading));
    }

    next(action);
  }
}
