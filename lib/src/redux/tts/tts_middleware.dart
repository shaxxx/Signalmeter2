import 'package:enigma_signal_meter/src/constants.dart';
import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/enigma/enigma_command_events.dart';
import 'package:enigma_signal_meter/src/redux/messages/warning_messages_events.dart';
import 'package:enigma_signal_meter/src/utils/tts_utils.dart';

import 'package:redux/redux.dart';

import 'tts_events.dart';

class TtsMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is SpeakSignalLevelSuccessEvent) {
      await Future.delayed(
          const Duration(milliseconds: ttsSpeakDelayInMiliseconds));
      store.dispatch(ChangeTtsStatusEvent(TtsStatus.Idle));
    } else if (action is SpeakSignalLevelErrorEvent) {
      store.dispatch(ChangeTtsStatusEvent(TtsStatus.Error));
      store.dispatch(TtsSpeakFailedMessageEvent(action.error));
    } else if (action is SpeakSignalLevelEvent) {
      var snr = action.response.signal.snr;
      if (snr != null && snr >= 0) {
        store.dispatch(ChangeTtsStatusEvent(TtsStatus.Speaking));
        await TtsUtils.speak(snr.toString());
      }
    } else if (action is GetSignalLevelSuccessEvent) {
      if (store.state.ttsState.ttsEnabled &&
          store.state.ttsState.ttsInitializationStatus ==
              TtsInitializationStatus.Initalized &&
          store.state.ttsState.status == TtsStatus.Idle) {
        store.dispatch(SpeakSignalLevelEvent(response: action.response));
      }
    } else if (action is InitializeTtsEvent) {
      store.dispatch(ChangeTtsInitializationStatusEvent(
          TtsInitializationStatus.ShouldInitialize));
    } else if (action is InitializeTtsSuccessEvent) {
      store.dispatch(ChangeTtsInitializationStatusEvent(
          TtsInitializationStatus.Initalized));
    } else if (action is InitializeTtsErrorEvent) {
      store.dispatch(
          ChangeTtsInitializationStatusEvent(TtsInitializationStatus.Error));
      store.dispatch(TtsInitFailedMessageEvent(action.error));
    } else if (action is ChangeTtsEnabledEvent) {
      if (store.state.ttsState.ttsInitializationStatus ==
          TtsInitializationStatus.Uninitalized) {
        store.dispatch(InitializeTtsEvent());
      }
    }
    next(action);
  }
}
