import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/enigma/enigma_command_events.dart';
import 'package:enigma_signal_meter/src/redux/services/bouquet_items_events.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';

class BouquetItemsListItemViewModel {
  final bool selected;
  final Function onTap;
  final IBouquetItem bouquetItem;
  String get name => bouquetItem?.name;
  bool get isMarker => this.bouquetItem is IBouquetItemMarker;

  const BouquetItemsListItemViewModel({
    @required this.selected,
    @required this.onTap,
    @required this.bouquetItem,
  });

  static BouquetItemsListItemViewModel fromStore(
      Store<AppState> store, IBouquetItem bouquetItem) {
    return new BouquetItemsListItemViewModel(
      selected: store.state.bouquetItemsState.selectedService == bouquetItem,
      bouquetItem: bouquetItem,
      onTap: () {
        if ((bouquetItem is IBouquetItemService)) {
          store.dispatch(
            BouquetItemSelectedEvent(
              bouquetItem: bouquetItem,
              switchTabs: true,
            ),
          );
          store.dispatch(
            ChangeServiceEvent(
              service: bouquetItem,
              profile: store.state.profilesState.selectedProfile,
            ),
          );
        }
      },
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BouquetItemsListItemViewModel &&
          runtimeType == other.runtimeType &&
          selected == other.selected &&
          bouquetItem == other.bouquetItem;

  @override
  int get hashCode => selected.hashCode ^ bouquetItem.hashCode;
}
