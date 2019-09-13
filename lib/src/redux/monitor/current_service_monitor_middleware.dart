import 'dart:async';

import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/enigma/enigma_command_events.dart';
import 'package:enigma_signal_meter/src/redux/monitor/current_service_monitor_events.dart';
import 'package:enigma_signal_meter/src/redux/tabs/tab_events.dart';
import 'package:enigma_signal_meter/src/utils/enigma_api.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:redux/redux.dart';
import 'package:logging/logging.dart';
import 'package:async/async.dart';

import '../../constants.dart';
import 'connection_state_events.dart';

class CurrentServiceMonitorMiddleware extends MiddlewareClass<AppState> {
  final IWebRequester requester;

  CurrentServiceMonitorMiddleware(this.requester);
  Timer _timer;
  CancelableOperation<dynamic> _operation;

  @override
  void call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is GetCurrentServiceErrorEvent) {
      Logger.root.fine(
          "Dispatching ChangeCurrentServiceMonitorStatusEvent from CurrentServiceMonitorMiddleware as response to GetCurrentServiceErrorEvent");
      store.dispatch(
          ChangeCurrentServiceMonitorStatusEvent(MonitorStatus.stopped));
    } else if (action is ConnectionStatusChangedEvent) {
      if (action.status == ConnectionStatusEnum.disconnected) {
        Logger.root.fine(
            "Dispatching ChangeCurrentServiceMonitorStatusEvent from CurrentServiceMonitorMiddleware as response to ConnectionStatusChangedEvent");
        store.dispatch(
            ChangeCurrentServiceMonitorStatusEvent(MonitorStatus.stopped));
      } else if (action.status == ConnectionStatusEnum.connected &&
          store.state.tabsState.tabPagesActive) {
        Logger.root.fine(
            "Dispatching ChangeCurrentServiceMonitorStatusEvent from CurrentServiceMonitorMiddleware as response to ConnectionStatusChangedEvent");
        store.dispatch(
            ChangeCurrentServiceMonitorStatusEvent(MonitorStatus.running));
      }
    } else if (action is TabPagesActiveChangedEvent) {
      if (!action.active) {
        Logger.root.fine(
            "Dispatching ChangeCurrentServiceMonitorStatusEvent from CurrentServiceMonitorMiddleware as response to TabPagesActiveChangedEvent");
        store.dispatch(
            ChangeCurrentServiceMonitorStatusEvent(MonitorStatus.stopped));
      } else if (action.active &&
          store.state.connectionState == ConnectionStatusEnum.connected) {
        Logger.root.fine(
            "Dispatching ChangeCurrentServiceMonitorStatusEvent from CurrentServiceMonitorMiddleware as response to TabPagesActiveChangedEvent");
        store.dispatch(
            ChangeCurrentServiceMonitorStatusEvent(MonitorStatus.running));
      }
    } else if (action is SignalChartFullScreenActiveChangedEvent) {
      if (!action.active) {
        if (store.state.tabsState.tabPagesActive &&
            store.state.tabsState.activeTab == TabPagesEnum.Signal) {
          Logger.root.fine(
              "NOT Dispatching ChangeCurrentServiceMonitorStatusEvent. Signal tab is visible.");
        } else {
          Logger.root.fine(
              "Dispatching ChangeCurrentServiceMonitorStatusEvent from CurrentServiceMonitorMiddleware as response to SignalChartFullScreenActiveChangedEvent");
          store.dispatch(
              ChangeCurrentServiceMonitorStatusEvent(MonitorStatus.stopped));
        }
      } else if (action.active &&
          store.state.connectionState == ConnectionStatusEnum.connected) {
        Logger.root.fine(
            "Dispatching ChangeCurrentServiceMonitorStatusEvent from CurrentServiceMonitorMiddleware as response to SignalChartFullScreenActiveChangedEvent");
        store.dispatch(
            ChangeCurrentServiceMonitorStatusEvent(MonitorStatus.running));
      }
    } else if (action is ChangeCurrentServiceMonitorStatusEvent) {
      _timer?.cancel();
      await _operation?.cancel();

      if (action.status == MonitorStatus.running) {
        _operation = CancelableOperation.fromFuture(_getCurrentService(store));
        _timer = Timer.periodic(
          currentServiceMonitorDelay,
          (Timer timer) {
            _operation?.cancel();
            _operation =
                CancelableOperation.fromFuture(_getCurrentService(store));
          },
        );
      }
    }
    next(action);
  }

  Future _getCurrentService(Store<AppState> store) async {
    try {
      var parser = GetCurrentServiceParser();
      var command = GetCurrentServiceCommand(
        parser,
        requester,
        store.state.profilesState.selectedProfile,
      );
      var response = await EnigmaApi.getCurrentServiceMonitor(
        profile: store.state.profilesState.selectedProfile,
        command: command,
        parser: parser,
        requester: requester,
      );
      store.dispatch(
        GetCurrentServiceSuccessEvent(
          responseDuration: response.responseDuration,
          response: response,
        ),
      );
    } catch (e) {
      store.dispatch(
        GetCurrentServiceErrorEvent(
          error: e,
          profile: store.state.profilesState.selectedProfile,
        ),
      );
    }
  }
}
