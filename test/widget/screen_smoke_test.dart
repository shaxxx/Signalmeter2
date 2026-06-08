import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:enigma_signal_meter/src/constants.dart';
import 'package:enigma_signal_meter/src/message_provider.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state_reducer.dart';
import 'package:enigma_signal_meter/src/ui/settings/settings_view.dart';

void main() {
  testWidgets('settings screen renders without error', (tester) async {
    final store = Store<AppState>(appReducer, initialState: AppState.inital());
    await tester.pumpWidget(
      StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          localizationsDelegates: const [
            SignalMeterLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: languages.map(
              (language) => Locale.fromSubtags(languageCode: language)),
          home: Scaffold(
            body: SettingsView(onSettingsChanged: (_) {}),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(SettingsView), findsOneWidget);
  });
}
