import 'package:collection/collection.dart';
import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/enigma/enigma_command_events.dart';
import 'package:enigma_signal_meter/src/redux/services/bouquet_items_events.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class BouquetItemsViewModel {
  BouquetItemsViewModel({
    @required this.status,
    @required this.bouquetItems,
    @required this.bouquet,
    @required this.refreshBouquetItems,
    @required this.searchTerm,
    @required this.onSearchTermChanged,
  });

  final LoadingStatus status;
  final List<IBouquetItem> bouquetItems;
  final Function refreshBouquetItems;
  final IBouquetItemBouquet bouquet;
  final String searchTerm;
  final void Function(String) onSearchTermChanged;

  bool get hasSearchTerm => searchTerm != null && searchTerm.trim().isNotEmpty;

  static BouquetItemsViewModel fromStore(
    Store<AppState> store,
  ) {
    return BouquetItemsViewModel(
      status: store.state.bouquetItemsState.status,
      bouquet: store.state.bouquetsState.selectedBouquet,
      bouquetItems: store.state.bouquetItemsState
          .bouquetItems(store.state.bouquetsState.selectedBouquet),
      refreshBouquetItems: () => store.dispatch(
        GetBouquetItemsEvent(
          profile: store.state.profilesState.selectedProfile,
          bouquet: store.state.bouquetsState.selectedBouquet,
        ),
      ),
      searchTerm: store.state.bouquetItemsState.searchTerm,
      onSearchTermChanged: (searchTerm) => store.dispatch(
        BouquetItemsSearchTermChanged(searchTerm),
      ),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BouquetItemsViewModel &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          const IterableEquality().equals(bouquetItems, other.bouquetItems) &&
          searchTerm == other.searchTerm;

  @override
  int get hashCode =>
      status.hashCode ^
      const IterableEquality().hash(bouquetItems) ^
      searchTerm.hashCode;
}
