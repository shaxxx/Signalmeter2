import 'package:enigma_signal_meter/src/redux/monitor/connection_state_events.dart';
import 'package:logging/logging.dart';

import 'package:redux/redux.dart';
import 'current_service_monitor_events.dart';
import 'current_service_monitor_state.dart';

final currentServiceMonitorReducer =
    combineReducers<CurrentServiceMonitorState>([
  TypedReducer<CurrentServiceMonitorState,
      ChangeCurrentServiceMonitorStatusEvent>(
    _changeCurrentServiceMonitorStatus,
  ),
  TypedReducer<CurrentServiceMonitorState, ResetStateEvent>(
    _currentServiceMonitorResetReducer,
  ),
]);

CurrentServiceMonitorState _changeCurrentServiceMonitorStatus(
    CurrentServiceMonitorState state,
    ChangeCurrentServiceMonitorStatusEvent event) {
  Logger.root.fine(
      'Current service monitor status changed to ${event.status.toString()}');
  return state.copyWith(status: event.status);
}

CurrentServiceMonitorState _currentServiceMonitorResetReducer(
    CurrentServiceMonitorState state, ResetStateEvent event) {
  Logger.root.fine('Reseting current service monitor.');
  return CurrentServiceMonitorState.inital();
}
