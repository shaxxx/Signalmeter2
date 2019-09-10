import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:meta/meta.dart';

@immutable
class TtsState {
  final TtsStatus status;
  final ISignalResponse response;
  final bool ttsEnabled;
  final TtsInitializationStatus ttsInitializationStatus;

  TtsState({
    @required this.status,
    @required this.response,
    @required this.ttsEnabled,
    @required this.ttsInitializationStatus,
  })  : assert(status != null),
        assert(ttsEnabled != null),
        assert(ttsInitializationStatus != null);

  static TtsState initial() {
    return TtsState(
      status: TtsStatus.Idle,
      response: null,
      ttsEnabled: false,
      ttsInitializationStatus: TtsInitializationStatus.Uninitalized,
    );
  }

  TtsState copyWith({
    TtsStatus status,
    ISignalResponse response,
    ISignalResponse previousResponse,
    bool ttsEnabled,
    TtsInitializationStatus ttsInitializationStatus,
  }) {
    return TtsState(
      status: status ?? this.status,
      response: response ?? this.response,
      ttsEnabled: ttsEnabled ?? this.ttsEnabled,
      ttsInitializationStatus:
          ttsInitializationStatus ?? this.ttsInitializationStatus,
    );
  }

  @override
  int get hashCode =>
      status.hashCode ^
      response.hashCode ^
      ttsEnabled.hashCode ^
      ttsInitializationStatus.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TtsState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          response == other.response &&
          ttsEnabled == other.ttsEnabled &&
          ttsInitializationStatus == other.ttsInitializationStatus;
}
