import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/monitor/connection_state_events.dart';
import 'package:logging/logging.dart';

import 'package:redux/redux.dart';

import 'tts_events.dart';
import 'tts_state.dart';

final ttsReducer = combineReducers<TtsState>([
  TypedReducer<TtsState, ChangeTtsStatusEvent>(_statusChangedReducer),
  TypedReducer<TtsState, ChangeTtsEnabledEvent>(_enabledChangedReducer),
  TypedReducer<TtsState, SpeakSignalLevelEvent>(_speakSignalReducer),
  TypedReducer<TtsState, ChangeTtsInitializationStatusEvent>(
      _initializationStatusReducer),
  TypedReducer<TtsState, ResetStateEvent>(_ttsResetStateEventReducer),
]);

TtsState _statusChangedReducer(TtsState state, ChangeTtsStatusEvent event) {
  Logger.root.fine('TTS status changed to ' + event.status.toString());
  return state.copyWith(status: event.status);
}

TtsState _enabledChangedReducer(TtsState state, ChangeTtsEnabledEvent event) {
  Logger.root.fine('TTS enabled is now ' + event.enable.toString());
  return state.copyWith(ttsEnabled: event.enable);
}

TtsState _speakSignalReducer(TtsState state, SpeakSignalLevelEvent event) {
  return state.copyWith(
    previousResponse: state.response,
    response: event.response,
  );
}

TtsState _initializationStatusReducer(
    TtsState state, ChangeTtsInitializationStatusEvent event) {
  Logger.root
      .fine('TTS initialization status changed to ' + event.status.toString());
  return state.copyWith(ttsInitializationStatus: event.status);
}

TtsState _ttsResetStateEventReducer(TtsState state, ResetStateEvent event) {
  Logger.root.fine('Reseting TTS state');
  return state.copyWith(
    status: TtsStatus.Idle,
    response: null,
    ttsEnabled: false,
  );
}
