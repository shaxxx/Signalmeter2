import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/enigma/enigma_command_events.dart';
import 'package:redux/redux.dart';

import 'error_messages_events.dart';

class MessagesMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, action, NextDispatcher next) {
    if (action is EnigmaCommandErrorEvent) {
      _dispatchErrorEvent(store, action);
    }
    next(action);
  }

  void _dispatchErrorEvent(
      Store<AppState> store, EnigmaCommandErrorEvent action) {
    store.dispatch(
      EnigmaCommandErrorMessageEvent(
        exception: action.error,
        action: action,
      ),
    );
  }
}
