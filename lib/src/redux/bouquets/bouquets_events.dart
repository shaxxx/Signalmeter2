import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:meta/meta.dart';

@immutable
class BouquetSelectedEvent {
  final IBouquetItemBouquet bouquet;
  final bool switchToServicesTab;
  BouquetSelectedEvent({
    @required this.bouquet,
    @required this.switchToServicesTab,
  })  : assert(bouquet != null),
        assert(switchToServicesTab != null);
}

@immutable
class BouquetsStatusChangedEvent {
  final LoadingStatus status;
  BouquetsStatusChangedEvent(this.status) : assert(status != null);
}

@immutable
class BouquetsStateResetEvent {}
