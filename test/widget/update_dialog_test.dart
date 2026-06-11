import 'package:enigma_signal_meter/src/constants.dart';
import 'package:enigma_signal_meter/src/message_provider.dart';
import 'package:enigma_signal_meter/src/model/desktop_updater.dart';
import 'package:enigma_signal_meter/src/ui/update/update_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:version/version.dart';

import '../helpers/fake_desktop_updater.dart';

Widget _harness(Widget dialog) {
  return MaterialApp(
    localizationsDelegates: const [
      SignalMeterLocalizationsDelegate(),
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales:
        languages.map((language) => Locale.fromSubtags(languageCode: language)),
    home: Scaffold(body: dialog),
  );
}

void main() {
  late FakeDesktopUpdater fake;

  setUp(() {
    fake = FakeDesktopUpdater();
    fake.setUpdateAvailable(Version(9, 9, 9));
  });

  UpdateDialog dialog({
    bool writable = true,
    bool grantResult = false,
    bool isMandatory = false,
  }) {
    fake.setUpdateAvailable(Version(9, 9, 9), isMandatory: isMandatory);
    return UpdateDialog(
      updater: fake,
      availability: fake.availability,
      isInstallDirWritable: () async => writable,
      grantInstallDirAccess: () async => grantResult,
    );
  }

  testWidgets('prompt shows version, release notes, Update and Later',
      (tester) async {
    fake.availability = DesktopUpdateAvailability(
      latest: Version(9, 9, 9),
      isMandatory: false,
      releaseNotes: 'feat: shiny new thing',
    );
    await tester.pumpWidget(_harness(UpdateDialog(
      updater: fake,
      availability: fake.availability,
      isInstallDirWritable: () async => true,
      grantInstallDirAccess: () async => false,
    )));
    await tester.pumpAndSettle();

    expect(find.textContaining('9.9.9'), findsOneWidget);
    expect(find.text('feat: shiny new thing'), findsOneWidget);
    expect(find.text('Update'), findsOneWidget);
    expect(find.text('Later'), findsOneWidget);
  });

  testWidgets('mandatory hides Later', (tester) async {
    await tester.pumpWidget(_harness(dialog(isMandatory: true)));
    await tester.pumpAndSettle();

    expect(find.text('Update'), findsOneWidget);
    expect(find.text('Later'), findsNothing);
  });

  testWidgets('non-writable install dir shows Allow instead of Update',
      (tester) async {
    await tester.pumpWidget(_harness(dialog(writable: false)));
    await tester.pumpAndSettle();

    expect(find.text('Allow'), findsOneWidget);
    expect(find.text('Update'), findsNothing);
  });

  testWidgets('failed grant shows the permission-failed line and keeps Allow',
      (tester) async {
    await tester.pumpWidget(
        _harness(dialog(writable: false, grantResult: false)));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Allow'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Permission was not granted'), findsOneWidget);
    expect(find.text('Allow'), findsOneWidget);
  });

  testWidgets('successful grant returns to the normal Update prompt',
      (tester) async {
    await tester
        .pumpWidget(_harness(dialog(writable: false, grantResult: true)));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Allow'));
    await tester.pumpAndSettle();

    expect(find.text('Update'), findsOneWidget);
    expect(find.text('Allow'), findsNothing);
  });

  testWidgets('Update runs to Staged and Restart calls restartAndApply once',
      (tester) async {
    fake.progressEvents = [
      const DesktopUpdateDownloading(0.4),
      DesktopUpdateStaged(Version(9, 9, 9)),
    ];
    await tester.pumpWidget(_harness(dialog()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Update'));
    await tester.pumpAndSettle();

    expect(fake.startUpdateCalls, 1);
    expect(find.textContaining('Restart'), findsWidgets);

    await tester.tap(find.text('Restart'));
    await tester.pumpAndSettle();

    expect(fake.restartAndApplyCalls, 1);
  });

  testWidgets('Failed event shows error state with Close', (tester) async {
    fake.progressEvents = [const DesktopUpdateFailed('boom')];
    await tester.pumpWidget(_harness(dialog()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Update'));
    await tester.pumpAndSettle();

    expect(find.text('Update failed.'), findsOneWidget);
    expect(find.text('Close'), findsOneWidget);
  });

  testWidgets('failed restart shows the error state', (tester) async {
    fake.progressEvents = [
      DesktopUpdateStaged(Version(9, 9, 9)),
    ];
    fake.restartShouldThrow = true;
    await tester.pumpWidget(_harness(dialog()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Update'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Restart'));
    await tester.pumpAndSettle();

    expect(fake.restartAndApplyCalls, 1);
    expect(find.text('Update failed.'), findsOneWidget);
  });

  testWidgets('mandatory dialog ignores Escape', (tester) async {
    fake.setUpdateAvailable(Version(9, 9, 9), isMandatory: true);
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: const [
        SignalMeterLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: languages
          .map((language) => Locale.fromSubtags(languageCode: language)),
      home: Builder(
        builder: (context) => Scaffold(
          body: TextButton(
            onPressed: () => showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (_) => UpdateDialog(
                updater: fake,
                availability: fake.availability,
                isInstallDirWritable: () async => true,
                grantInstallDirAccess: () async => false,
              ),
            ),
            child: const Text('open'),
          ),
        ),
      ),
    ));
    await tester.pumpAndSettle();
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(find.byType(UpdateDialog), findsOneWidget);

    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();

    expect(find.byType(UpdateDialog), findsOneWidget);
  });
}
