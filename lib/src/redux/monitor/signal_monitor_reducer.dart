import 'package:enigma_signal_meter/src/redux/enigma/enigma_command_events.dart';
import 'package:enigma_signal_meter/src/redux/monitor/connection_state_events.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';

import '../../constants.dart';
import 'signal_monitor_events.dart';
import 'signal_monitor_state.dart';

final signalMonitorReducer = combineReducers<SignalMonitorState>([
  TypedReducer<SignalMonitorState, ChangeSignalMonitorStatusEvent>(
    _changeSignalMonitorStatus,
  ),
  TypedReducer<SignalMonitorState, GetSignalLevelSuccessEvent>(
    _getSignalLevelSuccessReducer,
  ),
  TypedReducer<SignalMonitorState, ResetStateEvent>(
    _signalResetStateEvent,
  ),
]);

SignalMonitorState _changeSignalMonitorStatus(
    SignalMonitorState state, ChangeSignalMonitorStatusEvent event) {
  Logger.root.fine(
      "Current signal monitor status changed to ${event.status.toString()}");
  return state.copyWith(status: event.status);
}

SignalMonitorState _getSignalLevelSuccessReducer(
    SignalMonitorState state, GetSignalLevelSuccessEvent event) {
  var responses = List<ISignalResponse>()..addAll(state.responses);
  if (responses.length >= signalChartPoints) {
    responses.removeAt(0);
  }
  responses.add(event.response);
  return state.copyWith(responses: responses);
}

SignalMonitorState _signalResetStateEvent(
    SignalMonitorState state, ResetStateEvent event) {
  Logger.root.fine("Reseting signal state");
  return SignalMonitorState.initial();
}
