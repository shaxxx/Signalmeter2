import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/bouquets/bouquets_events.dart';
import 'package:enigma_signal_meter/src/redux/enigma/enigma_command_events.dart';
import 'package:enigma_signal_meter/src/redux/services/bouquet_items_events.dart';
import 'package:enigma_signal_meter/src/redux/tabs/tab_events.dart';
import 'package:redux/redux.dart';
import 'package:logging/logging.dart';

class TabsMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is WakeUpSuccessEvent) {
      Logger.root.fine(
          "Dispatching ActiveTabChangedEvent from TabsMiddleware as response to WakeUpSuccessEvent");
      store.dispatch(ActiveTabChangedEvent(TabPagesEnum.Bouquets));
    } else if (action is BouquetSelectedEvent && action.switchToServicesTab) {
      Logger.root.fine(
          "Dispatching ActiveTabChangedEvent from TabsMiddleware as response to BouquetSelectedEvent");
      store.dispatch(ActiveTabChangedEvent(TabPagesEnum.Services));
    } else if (action is BouquetItemSelectedEvent && action.switchTabs) {
      Logger.root.fine(
          "Dispatching ActiveTabChangedEvent from TabsMiddleware as response to BouquetItemSelectedEvent");
      store.dispatch(ActiveTabChangedEvent(TabPagesEnum.Signal));
    }
    next(action);
  }
}
