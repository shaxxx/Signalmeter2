import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/bouquets/bouquets_events.dart';
import 'package:enigma_signal_meter/src/redux/enigma/enigma_command_events.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';

import 'bouquet_items_events.dart';

class BouquetItemsMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is GetBouquetItemsErrorEvent) {
      Logger.root.fine(
          "Dispatching BouquetItemsStatusChangedEvent from BouquetItemsMiddleware as response to GetBouquetItemsErrorEvent");
      store.dispatch(BouquetItemsStatusChangedEvent(LoadingStatus.error));
    } else if (action is GetBouquetItemsSuccessEvent) {
      Logger.root.fine(
          "Dispatching BouquetItemsStatusChangedEvent from BouquetItemsMiddleware as response to GetBouquetItemsSuccessEvent");
      store.dispatch(BouquetItemsStatusChangedEvent(LoadingStatus.success));
    } else if (action is GetBouquetItemsEvent) {
      Logger.root.fine(
          "Dispatching BouquetItemsStatusChangedEvent from BouquetItemsMiddleware as response to GetBouquetItemsEvent");
      store.dispatch(BouquetItemsStatusChangedEvent(LoadingStatus.loading));
    } else if (action is BouquetSelectedEvent) {
      Logger.root.fine(
          "Dispatching GetBouquetItemsEvent from BouquetItemsMiddleware as response to BouquetSelectedEvent");
      store.dispatch(GetBouquetItemsEvent(
        profile: store.state.profilesState.selectedProfile,
        bouquet: action.bouquet,
      ));
    } else if (action is SentToSleepSuccessEvent) {
      Logger.root.fine(
          "Dispatching BouquetItemsStatusChangedEvent from BouquetItemsMiddleware as response to SentToSleepSuccessEvent");
      store.dispatch(BouquetItemsStatusChangedEvent(LoadingStatus.idle));
    } else if (action is GetCurrentServiceSuccessEvent) {
      if (action.response.currentService !=
          store.state.bouquetItemsState.selectedService) {
        Logger.root.fine(
            "Dispatching BouquetItemSelectedEvent from BouquetItemsMiddleware as response to GetCurrentServiceSuccessEvent");
        store.dispatch(BouquetItemSelectedEvent(
          bouquetItem: action.response.currentService,
          switchTabs: false,
        ));
      }
    }
    next(action);
  }
}
