import 'dart:core';
import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:enigma_signal_meter/src/i18n/messages.dart';
import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/model/menu_item.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/enigma/enigma_command_events.dart';
import 'package:enigma_signal_meter/src/redux/messages/error_messages_events.dart';
import 'package:enigma_signal_meter/src/redux/messages/info_messages_events.dart';
import 'package:enigma_signal_meter/src/redux/messages/warning_messages_events.dart';
import 'package:enigma_signal_meter/src/utils/stream_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:collection/collection.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app_routes.dart';
import '../../constants.dart';

class MoreViewModel {
  final List<MenuItem> menuItems;
  final Function(MenuItem menuItem) onSelected;
  final Messages messages;
  final String profileName;

  MoreViewModel({
    @required this.menuItems,
    @required this.onSelected,
    @required this.messages,
    @required this.profileName,
  }) : assert(menuItems != null);

  static MoreViewModel fromStore(
    Store<AppState> store,
    Messages messages,
  ) {
    return MoreViewModel(
      menuItems: _menuItemsFromStore(store, messages),
      onSelected: (item) {
        _setItemSelectedEvent(store, item);
      },
      messages: messages,
      profileName: store.state.profilesState.selectedProfile?.name,
    );
  }

  static List<MenuItem> _menuItemsFromStore(
      Store<AppState> store, Messages messages) {
    var menuItems = List<MenuItem>();
    if (store.state.ttsState.status != TtsStatus.Error) {
      menuItems.add(
        MenuItem(
          key: streamMenuItemKey,
          icon: menuIcons[streamMenuItemKey],
          title: messages.actionStream,
        ),
      );
      menuItems.add(
        MenuItem(
          key: screenshotMenuItemKey,
          icon: menuIcons[screenshotMenuItemKey],
          title: messages.actionScreenshot,
        ),
      );
      menuItems.add(
        MenuItem(
          key: sendToSleepMenuItemKey,
          icon: menuIcons[sendToSleepMenuItemKey],
          title: messages.actionSleep,
        ),
      );
      menuItems.add(
        MenuItem(
          key: restartMenuItemKey,
          icon: menuIcons[restartMenuItemKey],
          title: messages.actionRestart,
        ),
      );

      menuItems.add(
        MenuItem(
          key: aboutMenuItemKey,
          icon: menuIcons[aboutMenuItemKey],
          title: messages.actionAbout,
        ),
      );
    }
    return menuItems;
  }

  static void _setItemSelectedEvent(
      Store<AppState> store, MenuItem item) async {
    var profile = store.state.profilesState.selectedProfile;
    if (item.key == sendToSleepMenuItemKey) {
      store.dispatch(SentToSleepEvent(profile: profile));
    } else if (item.key == streamMenuItemKey) {
      _setStreamMenuItemEvent(store, item);
    } else if (item.key == restartMenuItemKey) {
      store.dispatch(RestartEvent(profile: profile));
    } else if (item.key == aboutMenuItemKey) {
      store.dispatch(NavigateToAction.push(AppRoutes.about));
    } else if (item.key == screenshotMenuItemKey) {
      store.dispatch(NavigateToAction.push(AppRoutes.screenshot));
    }
  }

  static void _setStreamMenuItemEvent(
    Store<AppState> store,
    MenuItem item,
  ) async {
    store.dispatch(InitializingStreamMessageEvent());

    var parameters = await StreamUtils.getStreamUrl(
      store.state.profilesState.selectedProfile,
      store.state.bouquetItemsState.selectedService,
    );

    if (parameters.getStreamParametersError != null) {
      store.dispatch(FailedStreamExtraParametersMessageEvent(
        response: parameters,
        exception: parameters.getStreamParametersError,
      ));
      return;
    }

    if (parameters.streamUri == null) {
      store.dispatch(FailedStreamPortMessageEvent());
      return;
    }

    if (Platform.isAndroid) {
      AndroidIntent intent = AndroidIntent(
        action: 'action_view',
        data: parameters.streamUri,
        type: 'video/*',
      );
      await intent.launch();
    } else {
      var iOSUri =
          'vlc-x-callback://x-callback-url/stream?url=' + parameters.streamUri;
      await launch(iOSUri);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoreViewModel &&
          runtimeType == other.runtimeType &&
          messages == other.messages &&
          const IterableEquality().equals(menuItems, other.menuItems);

  @override
  int get hashCode =>
      messages.hashCode ^ const IterableEquality().hash(menuItems);
}
