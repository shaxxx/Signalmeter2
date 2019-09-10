import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/enigma/enigma_command_events.dart';
import 'package:enigma_signal_meter/src/redux/monitor/connection_state_events.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';

import 'bouquets_events.dart';

class BouquetsMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is GetBouquetsErrorEvent) {
      Logger.root.fine(
          "Dispatching BouquetsStatusChangedEvent from BouquetsMiddleware as response to GetBouquetsErrorEvent");
      store.dispatch(BouquetsStatusChangedEvent(LoadingStatus.error));
    } else if (action is GetBouquetsSuccessEvent) {
      Logger.root.fine(
          "Dispatching BouquetsStatusChangedEvent from BouquetsMiddleware as response to GetBouquetsSuccessEvent");
      store.dispatch(BouquetsStatusChangedEvent(LoadingStatus.success));
      if (store.state.bouquetsState.selectedBouquet == null &&
          action.bouquets != null &&
          action.bouquets.length > 0) {
        Logger.root.fine(
            "Dispatching BouquetSelectedEvent from BouquetsMiddleware as response to GetBouquetsSuccessEvent");
        store.dispatch(BouquetSelectedEvent(
            bouquet: action.bouquets.first, switchToServicesTab: false));
      }
    } else if (action is GetBouquetsEvent) {
      Logger.root.fine(
          "Dispatching BouquetsStatusChangedEvent from BouquetsMiddleware as response to GetBouquetsEvent");
      store.dispatch(BouquetsStatusChangedEvent(LoadingStatus.loading));
    } else if (action is WakeUpSuccessEvent) {
      Logger.root.fine(
          "Dispatching GetBouquetsEvent from BouquetsMiddleware as response to WakeUpSuccessEvent");
      store.dispatch(
          GetBouquetsEvent(profile: store.state.profilesState.selectedProfile));
    } else if (action is SentToSleepSuccessEvent) {
      Logger.root.fine(
          "Dispatching BouquetsStatusChangedEvent from BouquetsMiddleware as response to SentToSleepSuccessEvent");
      store.dispatch(BouquetsStatusChangedEvent(LoadingStatus.idle));
    } else if (action is ConnectionStatusChangedEvent) {
      if (action.status == ConnectionStatusEnum.disconnected) {
        Logger.root.fine(
            "Dispatching BouquetsStateResetEvent from BouquetsMiddleware as response to ConnectionStatusChangedEvent");
        store.dispatch(BouquetsStateResetEvent());
      }
    }
    next(action);
  }
}
