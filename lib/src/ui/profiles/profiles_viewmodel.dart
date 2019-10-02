import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

import '../../app_routes.dart';

class ProfilesViewModel {
  final Function() addProfile;
  final ConnectionStatusEnum connectionState;

  ProfilesViewModel({this.addProfile, @required this.connectionState});

  static ProfilesViewModel fromStore(Store<AppState> store) {
    return ProfilesViewModel(
      addProfile:
          store.state.connectionState == ConnectionStatusEnum.connected ||
                  store.state.connectionState == ConnectionStatusEnum.connecting
              ? null
              : () {
                  store.dispatch(NavigateToAction(AppRoutes.profile));
                },
      connectionState: store.state.connectionState,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfilesViewModel &&
          runtimeType == other.runtimeType &&
          connectionState == other.connectionState;

  @override
  int get hashCode => connectionState.hashCode;
}
