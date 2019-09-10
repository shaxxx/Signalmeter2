import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/tabs/tab_events.dart';
import 'package:enigma_signal_meter/src/redux/tts/tts_events.dart';
import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';

class MainTabViewModel {
  final Function(TabPagesEnum page) onTabSelected;
  final Function(bool active) onActiveChanged;
  final bool showNavigator;
  final bool scrollable;
  final bool shouldInitializeTts;
  final void Function() onTtsInitialized;
  final void Function(dynamic error) onTtsInitError;
  final void Function() onSpeakEnd;
  final void Function(dynamic error) onSpeakError;

  MainTabViewModel({
    @required this.onTabSelected,
    @required this.onActiveChanged,
    @required this.showNavigator,
    @required this.scrollable,
    @required this.shouldInitializeTts,
    @required this.onTtsInitialized,
    @required this.onTtsInitError,
    @required this.onSpeakEnd,
    @required this.onSpeakError,
  });

  static MainTabViewModel fromStore(Store<AppState> store) {
    return MainTabViewModel(
      showNavigator: store.state.tabsState.tabPagesActive,
      scrollable: store.state.connectionState == ConnectionStatusEnum.connected,
      shouldInitializeTts: store.state.ttsState.ttsInitializationStatus ==
          TtsInitializationStatus.ShouldInitialize,
      onTabSelected: (page) {
        if (store.state.tabsState.activeTab != page) {
          store.dispatch(
            ActiveTabChangedEvent(
              page,
            ),
          );
        }
      },
      onActiveChanged: (active) {
        if (store.state.tabsState.tabPagesActive != active) {
          store.dispatch(
            TabPagesActiveChangedEvent(
              active,
            ),
          );
        }
      },
      onTtsInitialized: () => store.dispatch(InitializeTtsSuccessEvent()),
      onTtsInitError: (error) => store.dispatch(InitializeTtsErrorEvent(error)),
      onSpeakEnd: () => store.dispatch(SpeakSignalLevelSuccessEvent()),
      onSpeakError: (error) =>
          store.dispatch(SpeakSignalLevelErrorEvent(error)),
    );
  }

  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     other is MainTabViewModel &&
  //         runtimeType == other.runtimeType &&
  //         onTabSelected == other.onTabSelected &&
  //         onActiveChanged == other.onActiveChanged &&
  //         showNavigator == other.showNavigator &&
  //         scrollable == other.scrollable &&
  //         shouldInitializeTts == other.shouldInitializeTts &&
  //         onTtsInitialized == other.onTtsInitialized &&
  //         onTtsInitError == other.onTtsInitError &&
  //         onSpeakEnd == other.onSpeakEnd &&
  //         onSpeakError == other.onSpeakError;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainTabViewModel &&
          runtimeType == other.runtimeType &&
          showNavigator == other.showNavigator &&
          scrollable == other.scrollable &&
          shouldInitializeTts == other.shouldInitializeTts;

  // @override
  // int get hashCode =>
  //     onTabSelected.hashCode ^
  //     onActiveChanged.hashCode ^
  //     showNavigator.hashCode ^
  //     scrollable.hashCode ^
  //     shouldInitializeTts.hashCode ^
  //     onTtsInitialized.hashCode ^
  //     onTtsInitError.hashCode ^
  //     onSpeakEnd.hashCode ^
  //     onSpeakError.hashCode;

  @override
  int get hashCode =>
      showNavigator.hashCode ^
      scrollable.hashCode ^
      shouldInitializeTts.hashCode;
}
