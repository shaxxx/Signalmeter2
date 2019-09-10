import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:meta/meta.dart';

@immutable
class CurrentServiceMonitorState {
  final MonitorStatus status;
  final Exception loadingError;

  CurrentServiceMonitorState({
    @required this.status,
    @required this.loadingError,
  }) : assert(status != null);

  static CurrentServiceMonitorState inital() {
    return CurrentServiceMonitorState(
      status: MonitorStatus.stopped,
      loadingError: null,
    );
  }

  CurrentServiceMonitorState copyWith({
    MonitorStatus status,
  }) {
    return CurrentServiceMonitorState(
      status: status ?? this.status,
      loadingError: null,
    );
  }

  @override
  int get hashCode => status.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentServiceMonitorState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          loadingError == other.loadingError;
}
