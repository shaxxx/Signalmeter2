import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';

@immutable
class BouquetsState {
  final LoadingStatus status;
  final IBouquetItemBouquet selectedBouquet;
  final List<IBouquetItemBouquet> bouquets;
  final Exception loadingError;

  BouquetsState({
    @required this.status,
    @required this.selectedBouquet,
    @required this.bouquets,
    @required this.loadingError,
  }) : assert(status != null);

  static BouquetsState initial() {
    return BouquetsState(
        status: LoadingStatus.idle,
        bouquets: null,
        selectedBouquet: null,
        loadingError: null);
  }

  BouquetsState copyWith({
    LoadingStatus status,
    IBouquetItemBouquet selectedBouquet,
    List<IBouquetItemBouquet> bouquets,
    Exception loadingError,
  }) {
    return BouquetsState(
        status: status ?? this.status,
        selectedBouquet: selectedBouquet ?? this.selectedBouquet,
        bouquets: bouquets ?? this.bouquets,
        loadingError: loadingError ?? this.loadingError);
  }

  @override
  int get hashCode =>
      status.hashCode ^
      selectedBouquet.hashCode ^
      const IterableEquality().hash(bouquets);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BouquetsState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          selectedBouquet == other.selectedBouquet &&
          const IterableEquality().equals(bouquets, other.bouquets);
}
