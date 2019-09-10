import 'package:logging/logging.dart';

import 'package:redux/redux.dart';

import 'tab_events.dart';
import 'tab_state.dart';

final tabsReducer = combineReducers<TabState>([
  TypedReducer<TabState, ActiveTabChangedEvent>(_activeTabChangedReducer),
  TypedReducer<TabState, TabPagesActiveChangedEvent>(
      _tabPagesActiveChangeReducer),
  TypedReducer<TabState, SignalChartFullScreenActiveChangedEvent>(
      _signalChartFullScreenActiveChangedEvent),
  TypedReducer<TabState, ChangeSignalView>(_alternativeLookChangedReducer),
]);

TabState _activeTabChangedReducer(TabState state, ActiveTabChangedEvent event) {
  Logger.root.fine("Active tab set to " + event.tabPage.toString());
  return state.copyWith(activeTab: event.tabPage);
}

TabState _tabPagesActiveChangeReducer(
    TabState state, TabPagesActiveChangedEvent event) {
  Logger.root.fine("Tab pages activity set to " + event.active.toString());
  return state.copyWith(tabPagesActive: event.active);
}

TabState _signalChartFullScreenActiveChangedEvent(
    TabState state, SignalChartFullScreenActiveChangedEvent event) {
  Logger.root
      .fine("SignalChartFullScreen activity set to " + event.active.toString());
  return state.copyWith(signalChartFullScreenActive: event.active);
}

TabState _alternativeLookChangedReducer(
    TabState state, ChangeSignalView event) {
  return state.copyWith(signalView: event.view);
}
