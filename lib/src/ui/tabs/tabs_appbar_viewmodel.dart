import 'dart:core';
import 'package:enigma_signal_meter/src/i18n/messages.dart';
import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/model/menu_item.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/tabs/tab_events.dart';
import 'package:enigma_signal_meter/src/redux/tts/tts_events.dart';
import 'package:enigma_web/enigma_web.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:collection/collection.dart';
import 'package:redux/redux.dart';
import '../../constants.dart';

class TabsAppBarViewModel {
  final bool isVisible;
  final List<MenuItem> menuItems;
  final String title;
  final int visibleItemsCount;
  final Function(MenuItem menuItem) onSelected;
  final Messages messages;
  final String profileName;
  final TabPagesEnum activeTab;
  final SignalViewEnum signalView;

  TabsAppBarViewModel({
    @required this.isVisible,
    @required this.menuItems,
    @required this.title,
    @required this.visibleItemsCount,
    @required this.onSelected,
    @required this.messages,
    @required this.profileName,
    @required this.activeTab,
    @required this.signalView,
  })  : assert(isVisible != null),
        assert(menuItems != null);

  static TabsAppBarViewModel fromStore(
    Store<AppState> store,
    Messages messages,
  ) {
    return TabsAppBarViewModel(
      isVisible: true,
      menuItems: _menuItemsFromStore(store, messages),
      title: _getTitleForTab(store, messages),
      visibleItemsCount: visibleMenuItemsCount,
      onSelected: (item) {
        _setItemSelectedEvent(store, item);
      },
      messages: messages,
      profileName: store.state.profilesState.selectedProfile?.name,
      activeTab: store.state.tabsState.activeTab,
      signalView: store.state.tabsState.signalView,
    );
  }

  static String _getTitleForTab(Store<AppState> store, Messages messages) {
    switch (store.state.tabsState.activeTab) {
      case TabPagesEnum.Bouquets:
        return messages.bouquets;
        break;
      case TabPagesEnum.Services:
        return messages.services;
        break;
      case TabPagesEnum.Signal:
        return messages.signal;
        break;
      case TabPagesEnum.More:
        return messages.more;
        break;
      default:
        return appBarTitle;
    }
  }

  static List<MenuItem> _menuItemsFromStore(
      Store<AppState> store, Messages messages) {
    var menuItems = <MenuItem>[];
    if (store.state.connectionState == ConnectionStatusEnum.connected) {
      if (store.state.tabsState.activeTab == TabPagesEnum.Signal) {
        if (store.state.ttsState.status != TtsStatus.Error) {
          if (store.state.ttsState.ttsEnabled) {
            menuItems.add(
              MenuItem(
                key: disableTtsMenuItemKey,
                icon: menuIcons[disableTtsMenuItemKey],
                title: messages.disableTts,
              ),
            );
          } else {
            menuItems.add(
              MenuItem(
                key: enableTtsMenuItemKey,
                icon: menuIcons[enableTtsMenuItemKey],
                title: messages.enableTts,
              ),
            );
          }
        }
        if (store.state.tabsState.signalView != SignalViewEnum.Linear) {
          menuItems.add(
            MenuItem(
              key: defaultLookMenuItemKey,
              icon: menuIcons[defaultLookMenuItemKey],
              title: messages.defaultLook,
            ),
          );
        } else {
          menuItems.add(
            MenuItem(
              key: alternativeLookMenuItemKey,
              icon: menuIcons[alternativeLookMenuItemKey],
              title: messages.alternativeLook,
            ),
          );
        }
      }
    }
    return menuItems;
  }

  static void _setItemSelectedEvent(
      Store<AppState> store, MenuItem item) async {
    if (item.key == disableTtsMenuItemKey) {
      store.dispatch(ChangeTtsEnabledEvent(false));
    } else if (item.key == enableTtsMenuItemKey) {
      store.dispatch(ChangeTtsEnabledEvent(true));
    } else if (item.key == defaultLookMenuItemKey) {
      store.dispatch(ChangeSignalView(SignalViewEnum.Linear));
    } else if (item.key == alternativeLookMenuItemKey) {
      if (store.state.profilesState.selectedProfile.enigma ==
              EnigmaType.enigma2 &&
          store.state.globalState.applicationSettings.dbIsPrimaryLevel) {
        store.dispatch(ChangeSignalView(SignalViewEnum.CircularDb));
      } else {
        store.dispatch(ChangeSignalView(SignalViewEnum.CircularSnr));
      }
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TabsAppBarViewModel &&
          runtimeType == other.runtimeType &&
          isVisible == other.isVisible &&
          onSelected == other.onSelected &&
          visibleItemsCount == other.visibleItemsCount &&
          title == other.title &&
          messages == other.messages &&
          activeTab == other.activeTab &&
          const IterableEquality().equals(menuItems, other.menuItems);

  @override
  int get hashCode =>
      isVisible.hashCode ^
      onSelected.hashCode ^
      title.hashCode ^
      visibleItemsCount.hashCode ^
      messages.hashCode ^
      activeTab.hashCode ^
      const IterableEquality().hash(menuItems);
}
