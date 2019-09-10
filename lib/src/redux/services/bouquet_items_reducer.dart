import 'package:enigma_signal_meter/src/redux/enigma/enigma_command_events.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';

import 'bouquet_items_events.dart';
import 'bouquet_items_state.dart';

final bouquetsItemsReducer = combineReducers<BouquetItemsState>([
  TypedReducer<BouquetItemsState, BouquetItemSelectedEvent>(
      _bouquetItemSelectedReducer),
  TypedReducer<BouquetItemsState, BouquetItemsStatusChangedEvent>(
      _bouquetItemsStatusChangedReducer),
  TypedReducer<BouquetItemsState, GetBouquetItemsSuccessEvent>(
      _bouquetItemsLoadedReducer),
  TypedReducer<BouquetItemsState, GetBouquetItemsErrorEvent>(
      _bouquetItemsLoadingErrorReducer),
  TypedReducer<BouquetItemsState, BouquetItemsStateResetEvent>(
      _bouquetItemsStateResetReducer),
  TypedReducer<BouquetItemsState, SatellitesLoadedEvent>(
      _satellitesLoadedReducer),
  TypedReducer<BouquetItemsState, BouquetItemsSearchTermChanged>(
      _searchTermChangedReducer),
]);

BouquetItemsState _bouquetItemSelectedReducer(
    BouquetItemsState state, BouquetItemSelectedEvent event) {
  Logger.root.fine("Selected service " + event.bouquetItem.name);
  return state.copyWith(selectedService: event.bouquetItem);
}

BouquetItemsState _bouquetItemsStatusChangedReducer(
    BouquetItemsState state, BouquetItemsStatusChangedEvent event) {
  Logger.root.fine("Bouquet items " + event.status.toString());
  return state.copyWith(status: event.status);
}

BouquetItemsState _bouquetItemsLoadedReducer(
    BouquetItemsState state, GetBouquetItemsSuccessEvent event) {
  Logger.root.fine(
      "Loaded ${event.bouquetItems.length} bouquet items for bouquet ${event.bouquet} in ${event.responseDuration.inMilliseconds} ms");
  var cachedBouquetItems = Map<IBouquetItemBouquet, List<IBouquetItem>>();
  cachedBouquetItems.addAll(state.cachedBouquetItems);
  cachedBouquetItems.putIfAbsent(event.bouquet, () => event.bouquetItems);
  return state.copyWith(
      bouquetItems: event.bouquetItems, cachedBouquetItems: cachedBouquetItems);
}

BouquetItemsState _bouquetItemsLoadingErrorReducer(
    BouquetItemsState state, GetBouquetItemsErrorEvent event) {
  Logger.root.shout("Error loading bouquet items. ${event.error.toString()}");
  return state.copyWith(loadingError: event.error);
}

BouquetItemsState _bouquetItemsStateResetReducer(
    BouquetItemsState state, BouquetItemsStateResetEvent event) {
  Logger.root.fine("Reseting bouquet items status to inital.");
  return BouquetItemsState.initial();
}

BouquetItemsState _satellitesLoadedReducer(
    BouquetItemsState state, SatellitesLoadedEvent event) {
  Logger.root.fine("Loaded ${event.satellites.length} satellites.");
  return state.copyWith(satellites: event.satellites);
}

BouquetItemsState _searchTermChangedReducer(
    BouquetItemsState state, BouquetItemsSearchTermChanged event) {
  Logger.root.fine("Search term set to ${event.searchTerm}");
  return state.copyWith(searchTerm: event.searchTerm);
}
