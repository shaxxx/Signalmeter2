import 'package:enigma_signal_meter/src/constants.dart';
import 'package:enigma_signal_meter/src/message_provider.dart';
import 'package:enigma_signal_meter/src/ui/update/update_checker.dart';
import 'package:enigma_signal_meter/src/ui/update/update_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:version/version.dart';

import '../helpers/fake_desktop_updater.dart';

Widget _harness(GlobalKey<NavigatorState> navigatorKey) {
  return MaterialApp(
    navigatorKey: navigatorKey,
    localizationsDelegates: const [
      SignalMeterLocalizationsDelegate(),
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales:
        languages.map((language) => Locale.fromSubtags(languageCode: language)),
    home: const Scaffold(body: SizedBox()),
  );
}

void main() {
  late FakeDesktopUpdater fake;
  late GlobalKey<NavigatorState> navigatorKey;

  setUp(() {
    fake = FakeDesktopUpdater();
    navigatorKey = GlobalKey<NavigatorState>();
  });

  Future<void> check(WidgetTester tester, {bool isWindows = true}) async {
    await tester.pumpWidget(_harness(navigatorKey));
    await tester.pump(); // settle first frame so navigatorKey.currentContext is non-null
    await maybeShowUpdateDialog(
      navigatorKey.currentContext!,
      updater: fake,
      isWindows: isWindows,
      isInstallDirWritable: () async => true,
      grantInstallDirAccess: () async => false,
    );
    await tester.pumpAndSettle();
  }

  testWidgets('shows the dialog when an update is available', (tester) async {
    fake.setUpdateAvailable(Version(9, 9, 9));
    await check(tester);
    expect(find.byType(UpdateDialog), findsOneWidget);
  });

  testWidgets('does nothing when up to date (latest == null)', (tester) async {
    await check(tester);
    expect(find.byType(UpdateDialog), findsNothing);
  });

  testWidgets('does nothing on non-Windows platforms', (tester) async {
    fake.setUpdateAvailable(Version(9, 9, 9));
    await check(tester, isWindows: false);
    expect(fake.checkAvailabilityCalls, 0);
    expect(find.byType(UpdateDialog), findsNothing);
  });

  testWidgets('swallows check failures silently', (tester) async {
    fake.checkError = Exception('offline');
    await check(tester);
    expect(find.byType(UpdateDialog), findsNothing);
  });
}
