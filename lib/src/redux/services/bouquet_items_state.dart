import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';

@immutable
class BouquetItemsState {
  final LoadingStatus status;
  final IBouquetItemService selectedService;
  final Map<IBouquetItemBouquet, List<IBouquetItem>> cachedBouquetItems;
  final Exception loadingError;
  final Map<int, String> satellites;
  final String searchTerm;

  BouquetItemsState({
    @required this.status,
    @required this.selectedService,
    @required this.cachedBouquetItems,
    @required this.loadingError,
    @required this.satellites,
    @required this.searchTerm,
  })  : assert(status != null),
        assert(satellites != null),
        assert(cachedBouquetItems != null);

  static BouquetItemsState initial() {
    return BouquetItemsState(
      status: LoadingStatus.idle,
      selectedService: null,
      loadingError: null,
      cachedBouquetItems: Map<IBouquetItemBouquet, List<IBouquetItem>>(),
      satellites: Map<int, String>(),
      searchTerm: null,
    );
  }

  List<IBouquetItem> bouquetItems(IBouquetItemBouquet bouquet) {
    if (searchTerm == null || searchTerm.trim().length == 0) {
      return cachedBouquetItems[bouquet];
    }
    if (cachedBouquetItems[bouquet] == null) {
      return null;
    }
    var results = cachedBouquetItems[bouquet]
        .where((item) =>
            item is BouquetItemService &&
            item.name.toUpperCase().contains(this.searchTerm.toUpperCase()))
        .toList();
    return results;
  }

  BouquetItemsState copyWith({
    LoadingStatus status,
    IBouquetItemService selectedService,
    List<IBouquetItem> bouquetItems,
    Exception loadingError,
    Map<IBouquetItemBouquet, List<IBouquetItem>> cachedBouquetItems,
    Map<int, String> satellites,
    String searchTerm,
  }) {
    return BouquetItemsState(
      status: status ?? this.status,
      selectedService: selectedService ?? this.selectedService,
      loadingError: loadingError ?? this.loadingError,
      cachedBouquetItems: cachedBouquetItems ?? this.cachedBouquetItems,
      satellites: satellites ?? this.satellites,
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }

  @override
  int get hashCode =>
      status.hashCode ^
      selectedService.hashCode ^
      loadingError.hashCode ^
      const MapEquality().hash(cachedBouquetItems) ^
      const MapEquality().hash(satellites) ^
      searchTerm.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BouquetItemsState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          selectedService == other.selectedService &&
          loadingError == other.loadingError &&
          const MapEquality()
              .equals(cachedBouquetItems, other.cachedBouquetItems) &&
          const MapEquality().equals(satellites, other.satellites) &&
          searchTerm == other.searchTerm;
}
