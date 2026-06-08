import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:meta/meta.dart';

@immutable
class ConnectionStatusChangedEvent {
  final ConnectionStatusEnum status;
  const ConnectionStatusChangedEvent(this.status);
}

@immutable
class ResetStateEvent {}
