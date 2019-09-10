import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:meta/meta.dart';

@immutable
class TabState {
  final TabPagesEnum activeTab;
  final bool tabPagesActive;
  final bool signalChartFullScreenActive;
  final SignalViewEnum signalView;

  TabState({
    @required this.activeTab,
    @required this.tabPagesActive,
    @required this.signalChartFullScreenActive,
    @required this.signalView,
  })  : assert(activeTab != null),
        assert(signalView != null),
        assert(tabPagesActive != null),
        assert(signalChartFullScreenActive != null);

  static TabState initial() {
    return TabState(
      activeTab: TabPagesEnum.Bouquets,
      tabPagesActive: false,
      signalChartFullScreenActive: false,
      signalView: SignalViewEnum.Linear,
    );
  }

  TabState copyWith({
    TabPagesEnum activeTab,
    bool tabPagesActive,
    bool signalChartFullScreenActive,
    SignalViewEnum signalView,
  }) {
    return TabState(
      activeTab: activeTab ?? this.activeTab,
      tabPagesActive: tabPagesActive ?? this.tabPagesActive,
      signalChartFullScreenActive:
          signalChartFullScreenActive ?? this.signalChartFullScreenActive,
      signalView: signalView ?? this.signalView,
    );
  }

  @override
  int get hashCode =>
      activeTab.hashCode ^
      tabPagesActive.hashCode ^
      signalChartFullScreenActive.hashCode ^
      signalView.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TabState &&
          runtimeType == other.runtimeType &&
          activeTab == other.activeTab &&
          signalChartFullScreenActive == other.signalChartFullScreenActive &&
          signalView == other.signalView;
}
