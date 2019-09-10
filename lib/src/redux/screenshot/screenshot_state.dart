import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:meta/meta.dart';

@immutable
class ScreenshotState {
  final LoadingStatus status;
  final ScreenshotResponse response;

  ScreenshotState({
    @required this.status,
    @required this.response,
  }) : assert(status != null);

  static ScreenshotState initial() {
    return ScreenshotState(
      status: LoadingStatus.idle,
      response: null,
    );
  }

  ScreenshotState copyWith({
    LoadingStatus status,
    ScreenshotResponse response,
  }) {
    return ScreenshotState(
      status: status ?? this.status,
      response: response ?? this.response,
    );
  }

  @override
  int get hashCode => status.hashCode ^ response.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScreenshotState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          response == other.response;
}
