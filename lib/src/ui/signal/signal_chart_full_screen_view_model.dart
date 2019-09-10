import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/tabs/tab_events.dart';
import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';

class SignalChartFullScreenViewModel {
  final Function(bool active) onActiveChanged;

  SignalChartFullScreenViewModel({
    @required this.onActiveChanged,
  });

  static SignalChartFullScreenViewModel fromStore(Store<AppState> store) {
    return SignalChartFullScreenViewModel(
      onActiveChanged: (active) {
        if (store.state.tabsState.signalChartFullScreenActive != active) {
          store.dispatch(
            SignalChartFullScreenActiveChangedEvent(
              active,
            ),
          );
        }
      },
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignalChartFullScreenViewModel &&
          runtimeType == other.runtimeType &&
          onActiveChanged == other.onActiveChanged;

  @override
  int get hashCode => onActiveChanged.hashCode;
}
