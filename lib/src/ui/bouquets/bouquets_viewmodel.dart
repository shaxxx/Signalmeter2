import 'package:collection/collection.dart';
import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/enigma/enigma_command_events.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class BouquetsViewModel {
  BouquetsViewModel({
    @required this.status,
    @required this.bouquets,
    @required this.refreshBouquets,
    @required this.loadingError,
  });

  final LoadingStatus status;
  final List<IBouquetItemBouquet> bouquets;
  final Function refreshBouquets;
  final Exception loadingError;

  String get errorText => loadingError?.toString();

  static BouquetsViewModel fromStore(
    Store<AppState> store,
  ) {
    return BouquetsViewModel(
      status: store.state.bouquetsState.status,
      bouquets: store.state.bouquetsState.bouquets,
      loadingError: store.state.bouquetsState.loadingError,
      refreshBouquets: () => store.dispatch(
          GetBouquetsEvent(profile: store.state.profilesState.selectedProfile)),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BouquetsViewModel &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          loadingError == other.loadingError &&
          const IterableEquality().equals(bouquets, other.bouquets);

  @override
  int get hashCode =>
      status.hashCode ^
      loadingError.hashCode ^
      const IterableEquality().hash(bouquets);
}
