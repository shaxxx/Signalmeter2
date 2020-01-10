import 'dart:ui';

import 'package:enigma_signal_meter/src/model/application_settings.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart';

@immutable
class GlobalState {
  final Size screenSize;
  final Map<int, String> satellites;
  final WebRequester webRequester;
  final RouteObserver<PageRoute> routeObserver;
  final ApplicationSettings applicationSettings;

  GlobalState({
    @required this.screenSize,
    @required this.satellites,
    @required this.webRequester,
    @required this.routeObserver,
    @required this.applicationSettings,
  })  : assert(satellites != null),
        assert(webRequester != null),
        assert(routeObserver != null),
        assert(applicationSettings != null);

  static GlobalState initial() {
    return GlobalState(
      screenSize: null,
      satellites: <int, String>{},
      webRequester: WebRequester(
        Logger.root,
        connectTimeOut: 15000,
        receiveTimeOut: 15000,
      ),
      routeObserver: RouteObserver<PageRoute>(),
      applicationSettings: ApplicationSettings(dbIsPrimaryLevel: false),
    );
  }

  GlobalState copyWith({
    Size screenSize,
    Map<int, String> satellites,
    WebRequester webRequester,
    RouteObserver<PageRoute> routeObserver,
    ApplicationSettings applicationSettings,
  }) {
    return GlobalState(
      screenSize: screenSize ?? this.screenSize,
      satellites: satellites ?? this.satellites,
      webRequester: webRequester ?? this.webRequester,
      routeObserver: routeObserver ?? this.routeObserver,
      applicationSettings: applicationSettings ?? this.applicationSettings,
    );
  }

  @override
  int get hashCode =>
      screenSize.hashCode ^
      const MapEquality().hash(satellites) ^
      webRequester.hashCode ^
      routeObserver.hashCode ^
      applicationSettings.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GlobalState &&
          runtimeType == other.runtimeType &&
          screenSize == other.screenSize &&
          const MapEquality().equals(satellites, other.satellites) &&
          webRequester == other.webRequester &&
          routeObserver == other.routeObserver &&
          applicationSettings == other.applicationSettings;
}
