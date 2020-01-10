import 'package:enigma_signal_meter/src/redux/profiles/profiles_events.dart';
import 'package:enigma_signal_meter/src/redux/profiles/profiles_state.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';

final profilesReducer = combineReducers<ProfilesState>([
  TypedReducer<ProfilesState, ProfileSelectedEvent>(_profileSelectedReducer),
  TypedReducer<ProfilesState, ProfilesStatusChangedEvent>(
      _profilesStatusChangedReducer),
  TypedReducer<ProfilesState, LoadProfilesSuccessEvent>(
      _loadProfilesSuccessReducer),
  TypedReducer<ProfilesState, ProfileDeletedEvent>(_profileDeletedReducer),
  TypedReducer<ProfilesState, ProfileSaveEvent>(_profileSaveReducer),
]);

ProfilesState _profileSelectedReducer(
    ProfilesState state, ProfileSelectedEvent event) {
  if (event.profile != null) {
    Logger.root.fine('Selected profile ' + event.profile.name);
  } else {
    Logger.root.fine('Deselected profile');
  }
  return state.copyWith(selectedProfile: event.profile);
}

ProfilesState _profilesStatusChangedReducer(
    ProfilesState state, ProfilesStatusChangedEvent event) {
  Logger.root.fine('Profiles status changed to ' + event.status.toString());
  return state.copyWith(status: event.status);
}

ProfilesState _loadProfilesSuccessReducer(
    ProfilesState state, LoadProfilesSuccessEvent event) {
  Logger.root.fine(
      'Loaded ${event.profiles.length} profiles in ${event.responseDuration.inMilliseconds} ms');
  return state.copyWith(
    profiles: event.profiles,
    profilesLoaded: true,
  );
}

ProfilesState _profileDeletedReducer(
    ProfilesState state, ProfileDeletedEvent event) {
  Logger.root.fine('Deleted profile ${event.profile.name}');
  var profiles = List<IProfile>.from(state.profiles);
  profiles.remove(event.profile);
  return state.copyWith(profiles: profiles);
}

ProfilesState _profileSaveReducer(ProfilesState state, ProfileSaveEvent event) {
  var profiles = state.profiles.toList();
  var existingProfile =
      profiles.where((profile) => profile.id == event.profile.id).toList();
  if (existingProfile.isNotEmpty) {
    Logger.root.fine('Updating existing profile ${event.profile.name}');
    var index = profiles.indexOf(existingProfile.first);
    profiles.removeAt(index);
    profiles.insert(index, event.profile);
  } else {
    Logger.root.fine('Added new profile ${event.profile.name}');
    profiles.add(event.profile);
  }
  return state.copyWith(profiles: profiles);
}
