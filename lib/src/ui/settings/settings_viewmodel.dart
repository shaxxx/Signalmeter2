import 'package:enigma_signal_meter/src/model/application_settings.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app_routes.dart';

class SettingsViewModel {
  final ApplicationSettings applicationSettings;
  final VoidCallback onAbout;
  void Function(String url) onSupport;

  SettingsViewModel({
    @required this.applicationSettings,
    @required this.onAbout,
    @required this.onSupport,
  }) : assert(applicationSettings != null);

  static SettingsViewModel fromStore(Store<AppState> store) {
    return SettingsViewModel(
      applicationSettings: store.state.globalState.applicationSettings,
      onAbout: () => store.dispatch(NavigateToAction.push(AppRoutes.about)),
      onSupport: (url) => launch(url),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsViewModel &&
          runtimeType == other.runtimeType &&
          applicationSettings == other.applicationSettings;

  @override
  int get hashCode => applicationSettings.hashCode;
}
