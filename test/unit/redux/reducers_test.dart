import 'package:flutter_test/flutter_test.dart';
import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state_reducer.dart';
import 'package:enigma_signal_meter/src/redux/tabs/tabs_reducer.dart';
import 'package:enigma_signal_meter/src/redux/tabs/tab_state.dart';
import 'package:enigma_signal_meter/src/redux/tabs/tab_events.dart';
import 'package:enigma_signal_meter/src/redux/bouquets/bouquets_reducer.dart';
import 'package:enigma_signal_meter/src/redux/bouquets/bouquets_state.dart';
import 'package:enigma_signal_meter/src/redux/bouquets/bouquets_events.dart';

void main() {
  group('appReducer', () {
    test('unknown action returns unchanged initial state', () {
      final initial = AppState.inital();
      final result = appReducer(initial, Object());
      expect(result, isA<AppState>());
      expect(result, equals(initial));
    });
  });

  group('tabsReducer', () {
    test('ActiveTabChangedEvent changes activeTab and leaves signalView unchanged', () {
      final initial = TabState.initial();
      // Initial activeTab is Bouquets; change to Services
      final result = tabsReducer(initial, const ActiveTabChangedEvent(TabPagesEnum.Services));
      expect(result.activeTab, TabPagesEnum.Services);
      expect(result.signalView, initial.signalView);
    });

    test('SignalChartFullScreenActiveChangedEvent(true) sets signalChartFullScreenActive true', () {
      final initial = TabState.initial();
      final result = tabsReducer(initial, const SignalChartFullScreenActiveChangedEvent(true));
      expect(result.signalChartFullScreenActive, isTrue);
      expect(result.activeTab, initial.activeTab);
      expect(result.signalView, initial.signalView);
    });
  });

  group('bouquetsReducer', () {
    test('BouquetsStatusChangedEvent(loading) sets status to loading and leaves bouquets/selectedBouquet null', () {
      final initial = BouquetsState.initial();
      final result = bouquetsReducer(initial, const BouquetsStatusChangedEvent(LoadingStatus.loading));
      expect(result.status, LoadingStatus.loading);
      expect(result.bouquets, isNull);
      expect(result.selectedBouquet, isNull);
    });
  });
}
