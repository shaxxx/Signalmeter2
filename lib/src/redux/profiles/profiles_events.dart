import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:meta/meta.dart';

@immutable
class ProfileSelectedEvent {
  final IProfile? profile;
  ProfileSelectedEvent(this.profile);
}

@immutable
class ProfileDeletedEvent {
  final Profile profile;
  ProfileDeletedEvent(this.profile);
}

@immutable
class ProfilesStatusChangedEvent {
  final LoadingStatus status;
  ProfilesStatusChangedEvent(this.status);
}

@immutable
class ProfileSaveEvent {
  final IProfile profile;
  ProfileSaveEvent(this.profile);
}

@immutable
class LoadProfilesEvent {}

@immutable
class LoadProfilesSuccessEvent {
  final Duration responseDuration;
  final List<IProfile> profiles;

  LoadProfilesSuccessEvent({
    required this.responseDuration,
    required this.profiles,
  });
}

@immutable
class LoadProfilesErrorEvent {
  final dynamic error;
  LoadProfilesErrorEvent({required this.error}) : assert(error != null);
}
