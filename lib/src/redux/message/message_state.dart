import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:meta/meta.dart';

@immutable
class MessageState {
  final LoadingStatus status;

  MessageState({
    @required this.status,
  }) : assert(status != null);

  static MessageState initial() {
    return MessageState(
      status: LoadingStatus.idle,
    );
  }

  MessageState copyWith({
    LoadingStatus status,
  }) {
    return MessageState(
      status: status ?? this.status,
    );
  }

  @override
  int get hashCode => status.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageState &&
          runtimeType == other.runtimeType &&
          status == other.status;
}
