import 'package:redux/redux.dart';
import 'package:logging/logging.dart';

import 'global_events.dart';
import 'global_state.dart';

final globalReducer = combineReducers<GlobalState>([
  TypedReducer<GlobalState, SetScreenSizeEvent>(_screenSizeEventReducer),
  TypedReducer<GlobalState, SatellitesLoadedEvent>(_satellitesLoadedReducer),
  TypedReducer<GlobalState, ApplicationSettingsChangedEvent>(
      _appSettingsLoadedReducer),
]);

GlobalState _screenSizeEventReducer(
    GlobalState state, SetScreenSizeEvent event) {
  return state.copyWith(screenSize: event.screenSize);
}

GlobalState _satellitesLoadedReducer(
    GlobalState state, SatellitesLoadedEvent event) {
  Logger.root.fine("Loaded ${event.satellites.length} satellites.");
  return state.copyWith(satellites: event.satellites);
}

GlobalState _appSettingsLoadedReducer(
    GlobalState state, ApplicationSettingsChangedEvent event) {
  Logger.root.fine("Reloaded application settings");
  return state.copyWith(applicationSettings: event.applicationSettings);
}
