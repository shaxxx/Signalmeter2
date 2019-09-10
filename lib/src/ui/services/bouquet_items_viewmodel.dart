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
    @required this.loadingError,
    @required this.searchTerm,
    @required this.onSearchTermChanged,
  });

  final LoadingStatus status;
  final List<IBouquetItem> bouquetItems;
  final Function refreshBouquetItems;
  final Exception loadingError;
  final IBouquetItemBouquet bouquet;
  final String searchTerm;
  final void Function(String) onSearchTermChanged;

  bool get hasSearchTerm =>
      this.searchTerm != null && this.searchTerm.trim().length > 0;

  String get errorText => loadingError?.toString();

  static BouquetItemsViewModel fromStore(
    Store<AppState> store,
  ) {
    return BouquetItemsViewModel(
      status: store.state.bouquetItemsState.status,
      bouquet: store.state.bouquetsState.selectedBouquet,
      bouquetItems: store.state.bouquetItemsState
          .bouquetItems(store.state.bouquetsState.selectedBouquet),
      loadingError: store.state.bouquetItemsState.loadingError,
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
          loadingError == other.loadingError &&
          const IterableEquality().equals(bouquetItems, other.bouquetItems) &&
          searchTerm == other.searchTerm;

  @override
  int get hashCode =>
      status.hashCode ^
      loadingError.hashCode ^
      const IterableEquality().hash(bouquetItems) ^
      searchTerm.hashCode;
}
