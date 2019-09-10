import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/monitor/connection_state_events.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';

import '../../app_routes.dart';

class NavigationMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is ConnectionStatusChangedEvent) {
      if (action.status == ConnectionStatusEnum.connected) {
        store.dispatch(
          NavigateToAction.push(AppRoutes.mainTabView),
        );
      } else if (action.status == ConnectionStatusEnum.disconnected) {
        store.dispatch(
          NavigateToAction.popUntil(
            ModalRoute.withName(AppRoutes.home),
          ),
        );
      }
    }

    next(action);
  }
}
