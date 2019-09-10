import 'package:enigma_signal_meter/src/app_routes.dart';
import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/enigma/enigma_command_events.dart';
import 'package:enigma_signal_meter/src/redux/profiles/profiles_events.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';

class ProfileListItemViewModel {
  String get name => _name;
  String get address => _address;
  bool get connectButtonEnabled =>
      connectionStatus == ConnectionStatusEnum.disconnected ||
      connectionStatus == ConnectionStatusEnum.connecting;
  bool get disconnectButtonEnabled =>
      connectionStatus == ConnectionStatusEnum.connected ||
      connectionStatus == ConnectionStatusEnum.disconnecting;
  bool get progressBarEnabled =>
      connectionStatus == ConnectionStatusEnum.connecting ||
      connectionStatus == ConnectionStatusEnum.disconnecting;
  bool get deleteButtonEnabled =>
      connectionStatus == ConnectionStatusEnum.disconnected ||
      connectionStatus == ConnectionStatusEnum.error;

  final bool selected;
  final VoidCallback onTap;
  final ConnectionStatusEnum connectionStatus;

  String _name;
  String _address;
  final bool isClickable;
  final VoidCallback onConnect;
  final VoidCallback onDisconnect;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  ProfileListItemViewModel({
    @required this.selected,
    @required this.onTap,
    @required this.connectionStatus,
    this.onConnect,
    this.onDisconnect,
    this.onEdit,
    this.onDelete,
    String name,
    String address,
  })  : _name = name,
        _address = address,
        isClickable = _isDisconnected(connectionStatus);

  static bool _isDisconnected(ConnectionStatusEnum connectionStatus) {
    return connectionStatus == ConnectionStatusEnum.disconnected ||
        connectionStatus == ConnectionStatusEnum.error;
  }

  static String _addressWithPort(IProfile profile) {
    if (profile.httpPort != 80 && profile.httpPort != 443) {
      return profile.address + ':' + profile.httpPort.toString();
    }
    return profile.address;
  }

  static ProfileListItemViewModel fromStore(
    Store<AppState> store,
    IProfile profile,
  ) {
    return ProfileListItemViewModel(
      name: profile.name,
      address: _addressWithPort(profile),
      selected: store.state.profilesState?.selectedProfile == profile,
      connectionStatus: store.state.connectionState,
      onConnect: !_isDisconnected(store.state.connectionState)
          ? null
          : () {
              store.dispatch(
                WakeUpEvent(
                  profile: profile,
                ),
              );
            },
      onDisconnect:
          store.state.connectionState != ConnectionStatusEnum.connected
              ? null
              : () {
                  store.dispatch(
                    SentToSleepEvent(
                      profile: profile,
                    ),
                  );
                },
      onTap: () {
        store.dispatch(
          ProfileSelectedEvent(profile),
        );
      },
      onEdit: _isDisconnected(store.state.connectionState)
          ? () {
              store.dispatch(NavigateToAction(
                AppRoutes.profile,
                arguments: profile,
              ));
            }
          : null,
      onDelete: _isDisconnected(store.state.connectionState)
          ? () {
              store.dispatch(
                ProfileDeletedEvent(profile),
              );
            }
          : null,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileListItemViewModel &&
          runtimeType == other.runtimeType &&
          selected == other.selected &&
          name == other.name &&
          address == other.address &&
          connectionStatus == other.connectionStatus;

  @override
  int get hashCode =>
      selected.hashCode ^
      name.hashCode ^
      address.hashCode ^
      connectionStatus.hashCode;
}
