import 'dart:async';
import 'dart:ui';

import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';

@immutable
class ProfilesState {
  final LoadingStatus status;
  final IProfile selectedProfile;
  final List<IProfile> profiles;
  final StreamController<IProfile> profilesStream;

  ProfilesState({
    @required this.status,
    @required this.selectedProfile,
    @required this.profiles,
  })  : profilesStream = StreamController<IProfile>.broadcast(),
        assert(status != null),
        assert(profiles != null);

  static ProfilesState initial() {
    return ProfilesState(
      status: LoadingStatus.idle,
      selectedProfile: null,
      profiles: List<IProfile>(),
    );
  }

  ProfilesState copyWith({
    LoadingStatus status,
    IProfile selectedProfile,
    List<IProfile> profiles,
    Size screenSize,
  }) {
    return ProfilesState(
      status: status ?? this.status,
      selectedProfile: selectedProfile ?? this.selectedProfile,
      profiles: profiles ?? this.profiles,
    );
  }

  @override
  int get hashCode =>
      status.hashCode ^
      selectedProfile.hashCode ^
      const IterableEquality().hash(profiles);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfilesState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          selectedProfile == other.selectedProfile &&
          const IterableEquality().equals(profiles, other.profiles);
}
