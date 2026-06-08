import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';

@immutable
class BouquetItemsState {
  final LoadingStatus status;
  final IBouquetItemService? selectedService;
  final Map<IBouquetItemBouquet, List<IBouquetItem>> cachedBouquetItems;
  final String? searchTerm;

  const BouquetItemsState({
    required this.status,
    required this.selectedService,
    required this.cachedBouquetItems,
    required this.searchTerm,
  });

  static BouquetItemsState initial() {
    return BouquetItemsState(
      status: LoadingStatus.idle,
      selectedService: null,
      cachedBouquetItems: <IBouquetItemBouquet, List<IBouquetItem>>{},
      searchTerm: null,
    );
  }

  List<IBouquetItem>? bouquetItems(IBouquetItemBouquet bouquet) {
    final term = searchTerm;
    if (term == null || term.trim().isEmpty) {
      return cachedBouquetItems[bouquet];
    }
    final items = cachedBouquetItems[bouquet];
    if (items == null) {
      return null;
    }
    var results = items
        .where((item) =>
            item is BouquetItemService &&
            (item.name ?? '').toUpperCase().contains(term.toUpperCase()))
        .toList();
    return results;
  }

  BouquetItemsState copyWith({
    LoadingStatus? status,
    IBouquetItemService? selectedService,
    List<IBouquetItem>? bouquetItems,
    Exception? loadingError,
    Map<IBouquetItemBouquet, List<IBouquetItem>>? cachedBouquetItems,
    String? searchTerm,
  }) {
    return BouquetItemsState(
      status: status ?? this.status,
      selectedService: selectedService ?? this.selectedService,
      cachedBouquetItems: cachedBouquetItems ?? this.cachedBouquetItems,
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }

  @override
  int get hashCode =>
      status.hashCode ^
      selectedService.hashCode ^
      const MapEquality().hash(cachedBouquetItems) ^
      searchTerm.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BouquetItemsState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          selectedService == other.selectedService &&
          const MapEquality()
              .equals(cachedBouquetItems, other.cachedBouquetItems) &&
          searchTerm == other.searchTerm;
}
