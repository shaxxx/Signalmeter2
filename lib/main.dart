import 'package:enigma_signal_meter/src/app_routes.dart';
import 'package:enigma_signal_meter/src/redux/enigma/enigma_command_middleware.dart';
import 'package:enigma_signal_meter/src/redux/global/global_events.dart';
import 'package:enigma_signal_meter/src/redux/global/global_middleware.dart';
import 'package:enigma_signal_meter/src/redux/message/message_middleware.dart';
import 'package:enigma_signal_meter/src/redux/monitor/connection_state_middleware.dart';
import 'package:enigma_signal_meter/src/redux/monitor/current_service_monitor_middleware.dart';
import 'package:enigma_signal_meter/src/redux/screenshot/screenshot_middleware.dart';
import 'package:enigma_signal_meter/src/ui/about/about_view.dart';
import 'package:enigma_signal_meter/src/ui/home/home_view.dart';
import 'package:enigma_signal_meter/src/ui/message/message_view.dart';
import 'package:enigma_signal_meter/src/ui/screenshot/screenshot_view.dart';
import 'package:enigma_signal_meter/src/ui/signal/signal_chart_full_screen_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'src/constants.dart';
import 'src/message_provider.dart';
import 'src/redux/app/app_state.dart';
import 'src/redux/app/app_state_reducer.dart';
import 'src/redux/bouquets/bouquets_middleware.dart';
import 'src/redux/messages/messages_middleware.dart';
import 'src/redux/monitor/signal_monitor_middleware.dart';
import 'src/redux/profiles/profiles_events.dart';
import 'src/redux/profiles/profiles_middleware.dart';
import 'src/redux/services/bouquet_items_middleware.dart';
import 'src/redux/tabs/tabs_middleware.dart';
import 'src/redux/navigation/navigation_middleware.dart' as navigation;
import 'src/redux/tts/tts_middleware.dart';
import 'src/ui/profile/profile_edit_view.dart';
import 'src/ui/tabs/main_tab_view.dart';

void main() {
  //log only in debug mode
  if (!kReleaseMode) {
    Logger.root.level = Level.FINE;
    Logger.root.onRecord.listen((LogRecord rec) {
      print(rec.message);
    });
  }

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
  ));

  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.

  var initialState = AppState.inital();
  final store =
      Store<AppState>(appReducer, initialState: AppState.inital(), middleware: [
    EnigmaCommandMiddleware(
      initialState.globalState.webRequester,
    ),
    ConnectionStateMiddleware(),
    TabsMiddleware(),
    ProfilesMiddleware(),
    BouquetsMiddleware(),
    BouquetItemsMiddleware(),
    CurrentServiceMonitorMiddleware(
      initialState.globalState.webRequester,
    ),
    SignalMonitorMiddleware(),
    navigation.NavigationMiddleware(),
    NavigationMiddleware<AppState>(),
    MessagesMiddleware(),
    TtsMiddleware(),
    ScreenshotMiddleware(),
    MessageMiddleware(),
    GlobalMiddleware(),
    //LoggingMiddleware(logger: Logger.root),
  ]);

  Logger.root.info('Starting Signal Meter...');
  runApp(EnigmaSignalMeterApp(
    title: 'SignalMeter',
    store: store,
  ));
}

class EnigmaSignalMeterApp extends StatefulWidget {
  final Store<AppState> store;
  final String title;

  const EnigmaSignalMeterApp({
    Key key,
    @required this.store,
    @required this.title,
  }) : super(key: key);

  @override
  _EnigmaSignalMeterAppState createState() => _EnigmaSignalMeterAppState();
}

class _EnigmaSignalMeterAppState extends State<EnigmaSignalMeterApp>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    widget.store.dispatch(LoadApplicationSettingsEvent());
    widget.store.dispatch(LoadProfilesEvent());
    widget.store.dispatch(LoadSatellitesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        navigatorKey: NavigatorHolder.navigatorKey,
        navigatorObservers: [widget.store.state.globalState.routeObserver],
        theme: ThemeData.dark(),
        localizationsDelegates: [
          SignalMeterLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: languages.map((language) => Locale.fromSubtags(
              languageCode: language,
            )),
        //locale: Locale('hr', ''),
        title: 'SignalMeter',
        //debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.home,
        routes: {
          AppRoutes.home: (context) => HomeView(),
          AppRoutes.profile: (context) => ProfileEditView(),
          AppRoutes.mainTabView: (context) => MainTabView(),
          AppRoutes.signalChart: (context) => SignalChartFullScreen(),
          AppRoutes.about: (context) => AboutView(),
          AppRoutes.screenshot: (context) => ScreenshotView(),
          AppRoutes.message: (context) => MessageView(),
        },
      ),
    );
  }
}
