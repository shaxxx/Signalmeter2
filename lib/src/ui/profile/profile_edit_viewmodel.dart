import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/messages/info_messages_events.dart';
import 'package:enigma_signal_meter/src/redux/messages/warning_messages_events.dart';
import 'package:enigma_signal_meter/src/redux/profiles/profiles_events.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';

import '../../app_routes.dart';

class ProfileEditViewModel {
  final VoidCallback displayCheckingPortsInfoMessage;
  final VoidCallback displayFormInvalidWarningMessage;
  final void Function(IProfile) onSaveProfile;

  ProfileEditViewModel({
    @required this.displayCheckingPortsInfoMessage,
    @required this.displayFormInvalidWarningMessage,
    @required this.onSaveProfile,
  });

  static ProfileEditViewModel fromStore(Store<AppState> store) {
    return ProfileEditViewModel(displayCheckingPortsInfoMessage: () {
      store.dispatch(CheckingPortsInfoMessageEvent());
    }, displayFormInvalidWarningMessage: () {
      store.dispatch(FormInvalidMessageEvent());
    }, onSaveProfile: (profile) {
      store.dispatch(ProfileSaveEvent(profile));
      store.dispatch(ProfileSelectedEvent(profile));
      store.dispatch(
        NavigateToAction.popUntil(
          predicate: ModalRoute.withName(AppRoutes.home),
        ),
      );
    });
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileEditViewModel && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
