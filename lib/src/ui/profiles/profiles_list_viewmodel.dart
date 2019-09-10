import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:collection/collection.dart';

class ProfilesListViewModel {
  final LoadingStatus status;
  final ConnectionStatusEnum connectionStatus;
  final List<IProfile> profiles;

  ProfilesListViewModel({
    @required this.status,
    @required this.connectionStatus,
    @required this.profiles,
  }) : assert(profiles != null);

  static ProfilesListViewModel fromStore(Store<AppState> store) {
    return ProfilesListViewModel(
      status: store.state.profilesState.status,
      connectionStatus: store.state.connectionState,
      profiles: store.state.profilesState.profiles,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfilesListViewModel &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          connectionStatus == other.connectionStatus &&
          const IterableEquality().equals(profiles, other.profiles);

  @override
  int get hashCode =>
      status.hashCode ^
      connectionStatus.hashCode ^
      const IterableEquality().hash(profiles);
}
