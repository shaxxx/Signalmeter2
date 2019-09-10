import 'dart:ui';

import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:meta/meta.dart';

@immutable
class ProfileSelectedEvent {
  final Profile profile;
  ProfileSelectedEvent(this.profile);
}

@immutable
class ProfileDeletedEvent {
  final Profile profile;
  ProfileDeletedEvent(this.profile) : assert(profile != null);
}

@immutable
class ProfilesStatusChangedEvent {
  final LoadingStatus status;
  ProfilesStatusChangedEvent(this.status) : assert(status != null);
}

@immutable
class ProfileSaveEvent {
  final IProfile profile;
  ProfileSaveEvent(this.profile) : assert(profile != null);
}

@immutable
class LoadProfilesEvent {}

@immutable
class LoadProfilesSuccessEvent {
  final Duration responseDuration;
  final List<IProfile> profiles;

  LoadProfilesSuccessEvent({
    @required this.responseDuration,
    @required this.profiles,
  })  : assert(responseDuration != null),
        assert(profiles != null);
}

@immutable
class LoadProfilesErrorEvent {
  final dynamic error;
  LoadProfilesErrorEvent({this.error}) : assert(error != null);
}

@immutable
class SetScreenSizeEvent {
  final Size screenSize;
  SetScreenSizeEvent(this.screenSize);
}
