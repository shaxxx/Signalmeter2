import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/bouquets/bouquets_state.dart';
import 'package:enigma_signal_meter/src/redux/global/global_state.dart';
import 'package:enigma_signal_meter/src/redux/messages/messages_state.dart';
import 'package:enigma_signal_meter/src/redux/monitor/current_service_monitor_state.dart';
import 'package:enigma_signal_meter/src/redux/monitor/signal_monitor_state.dart';
import 'package:enigma_signal_meter/src/redux/profiles/profiles_state.dart';
import 'package:enigma_signal_meter/src/redux/screenshot/screenshot_state.dart';
import 'package:enigma_signal_meter/src/redux/services/bouquet_items_state.dart';
import 'package:enigma_signal_meter/src/redux/tabs/tab_state.dart';
import 'package:enigma_signal_meter/src/redux/tts/tts_state.dart';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final ConnectionStatusEnum connectionState;
  final CurrentServiceMonitorState currentServiceMonitorState;
  final SignalMonitorState signalMonitorState;
  final ProfilesState profilesState;
  final BouquetsState bouquetsState;
  final BouquetItemsState bouquetItemsState;
  final TabState tabsState;

  final MessagesState messagesState;
  final TtsState ttsState;
  final ScreenshotState screenshotState;
  final GlobalState globalState;

  factory AppState.inital() {
    return AppState._internal(
      connectionState: ConnectionStatusEnum.disconnected,
      currentServiceMonitorState: CurrentServiceMonitorState.inital(),
      signalMonitorState: SignalMonitorState.initial(),
      profilesState: ProfilesState.initial(),
      bouquetsState: BouquetsState.initial(),
      bouquetItemsState: BouquetItemsState.initial(),
      tabsState: TabState.initial(),
      messagesState: MessagesState.initial(),
      ttsState: TtsState.initial(),
      screenshotState: ScreenshotState.initial(),
      globalState: GlobalState.initial(),
    );
  }

  AppState copyWith({
    ConnectionStatusEnum connectionState,
    CurrentServiceMonitorState currentServiceMonitorState,
    SignalMonitorState signalMonitorState,
    ProfilesState profilesState,
    BouquetsState bouquetsState,
    BouquetItemsState bouquetItemsState,
    TabState tabsState,
    MessagesState messagesState,
    TtsState ttsState,
    ScreenshotState screenshotState,
    GlobalState globalState,
  }) {
    return AppState._internal(
      connectionState: connectionState ?? this.connectionState,
      currentServiceMonitorState:
          currentServiceMonitorState ?? this.currentServiceMonitorState,
      signalMonitorState: signalMonitorState ?? this.signalMonitorState,
      profilesState: profilesState ?? this.profilesState,
      bouquetsState: bouquetsState ?? this.bouquetsState,
      bouquetItemsState: bouquetItemsState ?? this.bouquetItemsState,
      tabsState: tabsState ?? this.bouquetItemsState,
      messagesState: messagesState ?? this.messagesState,
      ttsState: ttsState ?? this.ttsState,
      screenshotState: screenshotState ?? this.screenshotState,
      globalState: globalState ?? this.globalState,
    );
  }

  AppState._internal({
    this.connectionState,
    this.currentServiceMonitorState,
    this.signalMonitorState,
    this.profilesState,
    this.bouquetsState,
    this.bouquetItemsState,
    this.tabsState,
    this.messagesState,
    this.ttsState,
    this.screenshotState,
    this.globalState,
  });

  @override
  int get hashCode =>
      connectionState.hashCode ^
      currentServiceMonitorState.hashCode ^
      signalMonitorState.hashCode ^
      profilesState.hashCode ^
      bouquetsState.hashCode ^
      bouquetItemsState.hashCode ^
      tabsState.hashCode ^
      messagesState.hashCode ^
      ttsState.hashCode ^
      screenshotState.hashCode ^
      globalState.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          connectionState == other.connectionState &&
          currentServiceMonitorState == other.currentServiceMonitorState &&
          signalMonitorState == other.signalMonitorState &&
          profilesState == other.profilesState &&
          bouquetsState == other.bouquetsState &&
          bouquetItemsState == other.bouquetItemsState &&
          tabsState == other.tabsState &&
          messagesState == other.messagesState &&
          ttsState == other.ttsState &&
          screenshotState == other.screenshotState &&
          globalState == other.globalState;
}
