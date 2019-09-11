import 'package:enigma_signal_meter/src/redux/enigma/enigma_command_events.dart';
import 'package:enigma_signal_meter/src/redux/monitor/connection_state_events.dart';
import 'package:enigma_signal_meter/src/redux/screenshot/screenshot_events.dart';
import 'package:redux/redux.dart';

import 'screenshot_state.dart';

final screenshotReducer = combineReducers<ScreenshotState>([
  TypedReducer<ScreenshotState, ScreenshotStatusChangedEvent>(
      _screenshotStatusChangedReducer),
  TypedReducer<ScreenshotState, GetScreenShotOfCurrentServiceSuccessEvent>(
      _screenshotSuccessReducer),
  TypedReducer<ScreenshotState, GetScreenShotOfCurrentServiceErrorEvent>(
      _screenshotErrorReducer),
  TypedReducer<ScreenshotState, ResetStateEvent>(_screenshotStateResetReducer),
]);

ScreenshotState _screenshotStatusChangedReducer(
    ScreenshotState state, ScreenshotStatusChangedEvent event) {
  return state.copyWith(status: event.status);
}

ScreenshotState _screenshotSuccessReducer(
    ScreenshotState state, GetScreenShotOfCurrentServiceSuccessEvent event) {
  return state.copyWith(response: event.response);
}

ScreenshotState _screenshotErrorReducer(
    ScreenshotState state, GetScreenShotOfCurrentServiceErrorEvent event) {
  return state.copyWith(response: null);
}

ScreenshotState _screenshotStateResetReducer(
    ScreenshotState state, ResetStateEvent event) {
  return ScreenshotState.initial();
}
