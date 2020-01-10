import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/model/message_displayer_interface.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/messages/error_messages_events.dart';
import 'package:enigma_signal_meter/src/redux/messages/info_messages_events.dart';
import 'package:enigma_signal_meter/src/redux/messages/message_event.dart';
import 'package:enigma_signal_meter/src/redux/messages/warning_messages_events.dart';
import 'package:enigma_signal_meter/src/redux/monitor/connection_state_events.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:collection/collection.dart';

import '../../app_routes.dart';

class HomeViewModel implements MessageDisplayerInterface {
  final Function() onPop;

  @override
  final Function(MessageEvent message) messageShown;
  @override
  final List<ErrorMessageEvent> errors;
  @override
  final List<InfoMessageEvent> infos;
  @override
  final List<WarningMessageEvent> warnings;
  final Function() addProfile;
  final ConnectionStatusEnum connectionState;
  final Function() openAbout;
  final bool displayShowcase;

  HomeViewModel({
    @required this.onPop,
    this.errors,
    this.warnings,
    this.infos,
    this.messageShown,
    this.addProfile,
    this.openAbout,
    @required this.connectionState,
    @required this.displayShowcase,
  });

  static HomeViewModel fromStore(Store<AppState> store) {
    return HomeViewModel(
      onPop: store.state.connectionState != ConnectionStatusEnum.connected
          ? () {}
          : () {
              store.dispatch(
                ConnectionStatusChangedEvent(ConnectionStatusEnum.disconnected),
              );
            },
      errors: store.state.messagesState.errorMessages,
      warnings: store.state.messagesState.warningMessages,
      infos: store.state.messagesState.infoMessages,
      messageShown: (MessageEvent message) {
        if (message is ErrorMessageEvent) {
          store.dispatch(
            ErrorMessageShownEvent(message),
          );
        } else if (message is InfoMessageEvent) {
          store.dispatch(
            InfoMessageShownEvent(message),
          );
        } else if (message is WarningMessageEvent) {
          store.dispatch(
            WarningMessageShownEvent(message),
          );
        }
      },
      addProfile:
          store.state.connectionState == ConnectionStatusEnum.connected ||
                  store.state.connectionState == ConnectionStatusEnum.connecting
              ? null
              : () {
                  store.dispatch(NavigateToAction(AppRoutes.profile));
                },
      openAbout: () {
        store.dispatch(NavigateToAction(AppRoutes.about));
      },
      connectionState: store.state.connectionState,
      displayShowcase: store.state.profilesState.profilesLoaded &&
          store.state.profilesState.profiles.isEmpty,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeViewModel &&
          runtimeType == other.runtimeType &&
          connectionState == other.connectionState &&
          displayShowcase == other.displayShowcase &&
          const IterableEquality().equals(errors, other.errors) &&
          const IterableEquality().equals(infos, other.infos) &&
          const IterableEquality().equals(warnings, other.warnings);

  @override
  int get hashCode =>
      connectionState.hashCode ^
      displayShowcase.hashCode ^
      const IterableEquality().hash(errors) ^
      const IterableEquality().hash(infos) ^
      const IterableEquality().hash(warnings);
}
