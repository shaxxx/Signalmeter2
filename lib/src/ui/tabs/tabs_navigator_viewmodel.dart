import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/tabs/tab_events.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class TabsNavigatorViewModel {
  final ConnectionStatusEnum connectionStatus;
  final ValueChanged<int> onTap;
  final int currentIndex;

  TabsNavigatorViewModel({
    @required this.connectionStatus,
    @required this.onTap,
    @required this.currentIndex,
  })  : assert(connectionStatus != null),
        assert(currentIndex != null);

  bool get connected => connectionStatus == ConnectionStatusEnum.connected;

  static TabsNavigatorViewModel fromStore(Store<AppState> store) {
    return TabsNavigatorViewModel(
      connectionStatus: store.state.connectionState,
      currentIndex: store.state.tabsState.activeTab.index,
      onTap: (index) {
        if (index == 0 ||
            store.state.connectionState == ConnectionStatusEnum.connected) {
          store.dispatch(ActiveTabChangedEvent(TabPagesEnum.values[index]));
        }
      },
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TabsNavigatorViewModel &&
          runtimeType == other.runtimeType &&
          connectionStatus == other.connectionStatus &&
          currentIndex == other.currentIndex;

  @override
  int get hashCode => connectionStatus.hashCode ^ currentIndex.hashCode;
}
