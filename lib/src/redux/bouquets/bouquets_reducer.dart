import 'package:enigma_signal_meter/src/redux/enigma/enigma_command_events.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';

import 'bouquets_events.dart';
import 'bouquets_state.dart';

final bouquetsReducer = combineReducers<BouquetsState>([
  TypedReducer<BouquetsState, BouquetSelectedEvent>(_bouquetSelectedReducer),
  TypedReducer<BouquetsState, BouquetsStatusChangedEvent>(
      _bouquetsStatusChangedReducer),
  TypedReducer<BouquetsState, GetBouquetsSuccessEvent>(_bouquetsLoadedReducer),
  TypedReducer<BouquetsState, GetBouquetsErrorEvent>(
      _bouquetsLoadingErrorReducer),
  TypedReducer<BouquetsState, BouquetsStateResetEvent>(
      _bouquetsStateResetReducer),
]);

BouquetsState _bouquetSelectedReducer(
    BouquetsState state, BouquetSelectedEvent event) {
  Logger.root.fine("Selected bouquet " + event.bouquet.name);
  return state.copyWith(selectedBouquet: event.bouquet);
}

BouquetsState _bouquetsStatusChangedReducer(
    BouquetsState state, BouquetsStatusChangedEvent event) {
  Logger.root.fine("Bouquets " + event.status.toString());
  return state.copyWith(status: event.status);
}

BouquetsState _bouquetsLoadedReducer(
    BouquetsState state, GetBouquetsSuccessEvent event) {
  Logger.root.fine(
      "Loaded ${event.bouquets.length} bouquets in ${event.responseDuration.inMilliseconds} ms");
  return state.copyWith(bouquets: event.bouquets);
}

BouquetsState _bouquetsLoadingErrorReducer(
    BouquetsState state, GetBouquetsErrorEvent event) {
  Logger.root.shout("Error loading bouquets. ${event.error.toString()}");
  return state.copyWith(loadingError: event.error);
}

BouquetsState _bouquetsStateResetReducer(
    BouquetsState state, BouquetsStateResetEvent event) {
  Logger.root.fine("Reseting bouquets status to inital.");
  return BouquetsState.initial();
}
