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
  });

  final LoadingStatus status;
  final List<IBouquetItemBouquet> bouquets;
  final Function refreshBouquets;

  static BouquetsViewModel fromStore(
    Store<AppState> store,
  ) {
    return BouquetsViewModel(
      status: store.state.bouquetsState.status,
      bouquets: store.state.bouquetsState.bouquets,
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
          const IterableEquality().equals(bouquets, other.bouquets);

  @override
  int get hashCode => status.hashCode ^ const IterableEquality().hash(bouquets);
}
