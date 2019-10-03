import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/tabs/tab_events.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

@immutable
class SignalViewModel {
  final SignalViewEnum signalView;
  final void Function() onCycleView;

  SignalViewModel({
    @required this.signalView,
    @required this.onCycleView,
  }) : assert(signalView != null);

  static void _onCycleView(
    Store<AppState> store,
  ) {
    var signalView = store.state.tabsState.signalView;
    var useDb = (store.state.profilesState.selectedProfile.enigma ==
            EnigmaType.enigma2 &&
        store.state.globalState.applicationSettings.dbIsPrimaryLevel);

    if (signalView == SignalViewEnum.Linear) {
      if (useDb) {
        store.dispatch(ChangeSignalView(SignalViewEnum.CircularDb));
      } else {
        store.dispatch(ChangeSignalView(SignalViewEnum.CircularSnr));
      }
    } else if (signalView == SignalViewEnum.CircularSnr) {
      if (store.state.profilesState.selectedProfile.enigma ==
              EnigmaType.enigma2 &&
          !useDb) {
        store.dispatch(ChangeSignalView(SignalViewEnum.CircularDb));
      } else {
        store.dispatch(ChangeSignalView(SignalViewEnum.CircularAcg));
      }
    } else if (signalView == SignalViewEnum.CircularDb) {
      if (useDb) {
        store.dispatch(ChangeSignalView(SignalViewEnum.CircularSnr));
      } else {
        store.dispatch(ChangeSignalView(SignalViewEnum.CircularAcg));
      }
    } else if (signalView == SignalViewEnum.CircularAcg) {
      store.dispatch(ChangeSignalView(SignalViewEnum.CircularBer));
    } else if (signalView == SignalViewEnum.CircularBer) {
      store.dispatch(ChangeSignalView(SignalViewEnum.Linear));
    }
  }

  static SignalViewModel fromStore(Store<AppState> store) {
    return SignalViewModel(
      signalView: store.state.tabsState.signalView,
      onCycleView: () => _onCycleView(
        store,
      ),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignalViewModel &&
          runtimeType == other.runtimeType &&
          signalView == other.signalView;

  @override
  int get hashCode => signalView.hashCode;
}
