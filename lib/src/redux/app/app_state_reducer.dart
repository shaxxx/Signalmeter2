import 'package:enigma_signal_meter/src/redux/bouquets/bouquets_reducer.dart';
import 'package:enigma_signal_meter/src/redux/global/global_reducer.dart';
import 'package:enigma_signal_meter/src/redux/message/message_reducer.dart';
import 'package:enigma_signal_meter/src/redux/messages/messages_reducer.dart';
import 'package:enigma_signal_meter/src/redux/monitor/connection_state_reducer.dart';
import 'package:enigma_signal_meter/src/redux/monitor/current_service_monitor_reducer.dart';
import 'package:enigma_signal_meter/src/redux/monitor/signal_monitor_reducer.dart';
import 'package:enigma_signal_meter/src/redux/profiles/profiles_reducer.dart';
import 'package:enigma_signal_meter/src/redux/screenshot/screenshot_reducer.dart';
import 'package:enigma_signal_meter/src/redux/services/bouquet_items_reducer.dart';
import 'package:enigma_signal_meter/src/redux/tabs/tabs_reducer.dart';
import 'package:enigma_signal_meter/src/redux/tts/tts_reducer.dart';

import 'app_state.dart';

AppState appReducer(AppState state, action) {
  return state.copyWith(
    connectionState: connectionStateReducer(state.connectionState, action),
    currentServiceMonitorState:
        currentServiceMonitorReducer(state.currentServiceMonitorState, action),
    signalMonitorState: signalMonitorReducer(state.signalMonitorState, action),
    profilesState: profilesReducer(state.profilesState, action),
    bouquetsState: bouquetsReducer(state.bouquetsState, action),
    bouquetItemsState: bouquetsItemsReducer(state.bouquetItemsState, action),
    tabsState: tabsReducer(state.tabsState, action),
    messagesState: messagesReducer(state.messagesState, action),
    ttsState: ttsReducer(state.ttsState, action),
    screenshotState: screenshotReducer(state.screenshotState, action),
    messageState: messageReducer(state.messageState, action),
    globalState: globalReducer(state.globalState, action),
  );
}
