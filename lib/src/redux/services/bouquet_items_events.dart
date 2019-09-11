import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:meta/meta.dart';

@immutable
class BouquetItemSelectedEvent {
  final bool switchTabs;
  final IBouquetItemService bouquetItem;
  BouquetItemSelectedEvent({
    @required this.bouquetItem,
    @required this.switchTabs,
  })  : assert(bouquetItem != null),
        assert(switchTabs != null);
}

@immutable
class BouquetItemsStatusChangedEvent {
  final LoadingStatus status;
  BouquetItemsStatusChangedEvent(this.status) : assert(status != null);
}

@immutable
class LoadSatellitesEvent {}

@immutable
class SatellitesLoadedEvent {
  final Map<int, String> satellites;
  SatellitesLoadedEvent(this.satellites);
}

@immutable
class BouquetItemsSearchTermChanged {
  final String searchTerm;
  BouquetItemsSearchTermChanged(this.searchTerm);
}
