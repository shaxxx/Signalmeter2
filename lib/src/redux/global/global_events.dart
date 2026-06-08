import 'dart:ui';
import 'package:enigma_signal_meter/src/model/application_settings.dart';
import 'package:meta/meta.dart';

@immutable
class SetScreenSizeEvent {
  final Size screenSize;
  const SetScreenSizeEvent(this.screenSize);
}

@immutable
class LoadSatellitesEvent {}

@immutable
class LoadApplicationSettingsEvent {}

@immutable
class ApplicationSettingsChangedEvent {
  final ApplicationSettings applicationSettings;
  const ApplicationSettingsChangedEvent(this.applicationSettings);
}

@immutable
class SatellitesLoadedEvent {
  final Map<int, String> satellites;
  const SatellitesLoadedEvent(this.satellites);
}
