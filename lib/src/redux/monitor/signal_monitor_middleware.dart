import 'dart:async';

import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/enigma/enigma_command_events.dart';
import 'package:enigma_signal_meter/src/redux/tabs/tab_events.dart';
import 'package:enigma_signal_meter/src/utils/enigma_api.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:redux/redux.dart';
import 'package:logging/logging.dart';
import 'package:async/async.dart';
import 'package:wakelock/wakelock.dart';

import '../../constants.dart';
import 'connection_state_events.dart';
import 'signal_monitor_events.dart';

class SignalMonitorMiddleware extends MiddlewareClass<AppState> {
  IWebRequester _requester;
  CancelableOperation<dynamic> _operation;
  MonitorStatus _status;
  int _monitorHash;

  @override
  void call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is GetSignalLevelErrorEvent) {
      Logger.root.fine(
          "Dispatching ChangeSignalMonitorStatusEvent from SignalMonitorMiddleware as response to GetSignalErrorEvent");
      store.dispatch(ChangeSignalMonitorStatusEvent(MonitorStatus.stopped));
    } else if (action is ConnectionStatusChangedEvent) {
      if (action.status == ConnectionStatusEnum.disconnected) {
        Logger.root.fine(
            "Dispatching ChangeSignalMonitorStatusEvent from SignalMonitorMiddleware as response to ConnectionStatusChangedEvent");
        store.dispatch(ChangeSignalMonitorStatusEvent(MonitorStatus.stopped));
      }
    } else if (action is TabPagesActiveChangedEvent) {
      if (!action.active) {
        Logger.root.fine(
            "Dispatching ChangeSignalMonitorStatusEvent from SignalMonitorMiddleware as response to TabPagesActiveChangedEvent");
        store.dispatch(ChangeSignalMonitorStatusEvent(MonitorStatus.stopped));
      } else if (action.active &&
          store.state.tabsState.activeTab == TabPagesEnum.Signal) {
        Logger.root.fine(
            "Dispatching ChangeSignalMonitorStatusEvent from SignalMonitorMiddleware as response to TabPagesActiveChangedEvent");
        store.dispatch(ChangeSignalMonitorStatusEvent(MonitorStatus.running));
      }
    } else if (action is SignalChartFullScreenActiveChangedEvent) {
      if (!action.active) {
        if (store.state.tabsState.tabPagesActive &&
            store.state.tabsState.activeTab == TabPagesEnum.Signal) {
          Logger.root.fine(
              "NOT Dispatching ChangeSignalMonitorStatusEvent. Signal tab is visible.");
        } else {
          Logger.root.fine(
              "Dispatching ChangeSignalMonitorStatusEvent from SignalMonitorMiddleware as response to TabPagesActiveChangedEvent");
          store.dispatch(ChangeSignalMonitorStatusEvent(MonitorStatus.stopped));
        }
      } else if (action.active &&
          store.state.tabsState.activeTab == TabPagesEnum.Signal) {
        Logger.root.fine(
            "Dispatching ChangeSignalMonitorStatusEvent from SignalMonitorMiddleware as response to TabPagesActiveChangedEvent");
        store.dispatch(ChangeSignalMonitorStatusEvent(MonitorStatus.running));
      }
    } else if (action is ActiveTabChangedEvent) {
      if (action.tabPage != TabPagesEnum.Signal) {
        Logger.root.fine(
            "Dispatching ChangeSignalMonitorStatusEvent from SignalMonitorMiddleware as response to ActiveTabChangedEvent");
        store.dispatch(ChangeSignalMonitorStatusEvent(MonitorStatus.stopped));
      } else {
        Logger.root.fine(
            "Dispatching ChangeSignalMonitorStatusEvent from SignalMonitorMiddleware as response to ActiveTabChangedEvent");
        store.dispatch(ChangeSignalMonitorStatusEvent(MonitorStatus.running));
      }
    } else if (action is ChangeSignalMonitorStatusEvent) {
      _operation?.cancel();
      _status = action.status;
      _requester = WebRequester(
        Logger.root,
        receiveTimeoutRetries: signalMonitorRetries,
        receiveTimeOut: signalMonitorReceiveTimeout,
      );
      _monitorHash = store.state.signalMonitorState.hashCode;
      if (action.status == MonitorStatus.running) {
        Wakelock.enable();
        _operation = CancelableOperation.fromFuture(_getSignal(
          store,
          store.state.signalMonitorState.hashCode,
        ));
      } else {
        Wakelock.disable();
      }
    }
    next(action);
  }

  Future _getSignal(Store<AppState> store, int hash) async {
    try {
      var parser = SignalParser();
      var command = SignalCommand(
        parser,
        _requester,
        store.state.profilesState.selectedProfile,
      );
      while (_status == MonitorStatus.running && hash == _monitorHash) {
        var response = await EnigmaApi.readSignalLevelMonitor(
          profile: store.state.profilesState.selectedProfile,
          parser: parser,
          command: command,
          requester: _requester,
        );
        store.dispatch(
          GetSignalLevelSuccessEvent(
            responseDuration: response.responseDuration,
            response: response,
          ),
        );
      }
    } catch (e) {
      store.dispatch(
        GetSignalLevelErrorEvent(
          error: e,
          profile: store.state.profilesState.selectedProfile,
        ),
      );
    }
  }
}
