import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/bouquets/bouquets_events.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';

class BouquetsListItemViewModel {
  final bool selected;
  final Function onTap;
  final IBouquetItemBouquet bouquet;
  String get name => bouquet?.name;

  const BouquetsListItemViewModel({
    @required this.selected,
    @required this.onTap,
    @required this.bouquet,
  });

  static BouquetsListItemViewModel fromStore(
      Store<AppState> store, IBouquetItemBouquet bouquet) {
    return BouquetsListItemViewModel(
      selected: store.state.bouquetsState.selectedBouquet == bouquet,
      bouquet: bouquet,
      onTap: () => store.dispatch(
          BouquetSelectedEvent(bouquet: bouquet, switchToServicesTab: true)),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BouquetsListItemViewModel &&
          runtimeType == other.runtimeType &&
          selected == other.selected &&
          bouquet == other.bouquet;

  @override
  int get hashCode => selected.hashCode ^ bouquet.hashCode;
}
