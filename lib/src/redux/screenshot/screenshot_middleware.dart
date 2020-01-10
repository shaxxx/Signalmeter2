import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/enigma/enigma_command_events.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';

import 'screenshot_events.dart';

class ScreenshotMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is GetScreenShotOfCurrentServiceErrorEvent) {
      Logger.root.fine(
          'Dispatching ScreenshotStatusChangedEvent from ScreenshotMiddleware as response to GetScreenShotOfCurrentServiceErrorEvent');
      store.dispatch(ScreenshotStatusChangedEvent(LoadingStatus.error));
    } else if (action is GetScreenShotOfCurrentServiceSuccessEvent) {
      Logger.root.fine(
          'Dispatching ScreenshotStatusChangedEvent from ScreenshotMiddleware as response to GetScreenShotOfCurrentServiceSuccessEvent');
      store.dispatch(ScreenshotStatusChangedEvent(LoadingStatus.success));
    } else if (action is GetScreenShotOfCurrentServiceEvent) {
      Logger.root.fine(
          'Dispatching ScreenshotStatusChangedEvent from ScreenshotMiddleware as response to GetScreenShotOfCurrentServiceEvent');
      store.dispatch(ScreenshotStatusChangedEvent(LoadingStatus.loading));
    }

    next(action);
  }
}
