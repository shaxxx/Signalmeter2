import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/enigma/enigma_command_events.dart';
import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';

class ToggleConnectionViewModel {
  final bool visible;
  final Function toggleStatus;

  ToggleConnectionViewModel({
    @required this.visible,
    @required this.toggleStatus,
  });

  static ToggleConnectionViewModel fromStore(Store<AppState> store) {
    return ToggleConnectionViewModel(
        visible: (store.state.connectionState ==
                ConnectionStatusEnum.disconnected) ||
            (store.state.connectionState == ConnectionStatusEnum.error),
        toggleStatus: () async {
          if (store.state.connectionState != ConnectionStatusEnum.connected) {
            store.dispatch(WakeUpEvent(
              profile: store.state.profilesState.selectedProfile,
            ));
          } else {
            store.dispatch(SentToSleepEvent(
              profile: store.state.profilesState.selectedProfile,
            ));
          }
        });
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToggleConnectionViewModel &&
          runtimeType == other.runtimeType &&
          visible == other.visible;

  @override
  int get hashCode => visible.hashCode;
}
