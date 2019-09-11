import 'package:enigma_signal_meter/src/i18n/messages.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:collection/collection.dart';

class CurrentServiceViewModel {
  final IBouquetItemService currentService;
  final Map<int, String> satellites;
  final Messages messages;

  CurrentServiceViewModel({
    @required this.currentService,
    @required this.satellites,
    @required this.messages,
  }) : assert(messages != null);

  static CurrentServiceViewModel fromStore(
    Store<AppState> store,
    Messages messages,
  ) {
    return CurrentServiceViewModel(
        currentService: store.state.bouquetItemsState.selectedService,
        messages: messages,
        satellites: store.state.bouquetItemsState.satellites);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentServiceViewModel &&
          runtimeType == other.runtimeType &&
          currentService == other.currentService &&
          satellites == other.satellites &&
          messages == other.messages;

  @override
  int get hashCode =>
      currentService.hashCode ^
      messages.hashCode ^
      const MapEquality().hash(satellites);
}
