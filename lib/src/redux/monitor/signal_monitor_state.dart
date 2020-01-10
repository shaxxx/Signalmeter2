import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';

@immutable
class SignalMonitorState {
  final MonitorStatus status;
  final List<ISignalResponse> responses;

  SignalMonitorState({
    @required this.status,
    @required this.responses,
  }) : assert(status != null);

  static SignalMonitorState initial() {
    return SignalMonitorState(
      status: MonitorStatus.stopped,
      responses: <ISignalResponse>[],
    );
  }

  SignalMonitorState copyWith({
    MonitorStatus status,
    List<ISignalResponse> responses,
  }) {
    return SignalMonitorState(
        status: status ?? this.status, responses: responses ?? this.responses);
  }

  @override
  int get hashCode =>
      status.hashCode ^ const IterableEquality().hash(responses);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignalMonitorState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          const IterableEquality().equals(responses, other.responses);
}
