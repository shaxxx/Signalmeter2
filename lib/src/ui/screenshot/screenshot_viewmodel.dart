import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/enigma/enigma_command_events.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';

class ScreenshotViewModel {
  final LoadingStatus status;
  final ScreenshotResponse response;
  final IProfile profile;
  final Function(ScreenshotType) takeScreenshot;

  ScreenshotViewModel({
    @required this.status,
    @required this.response,
    @required this.profile,
    @required this.takeScreenshot,
  })  : assert(status != null),
        assert(profile != null),
        assert(takeScreenshot != null);

  static ScreenshotViewModel fromStore(Store<AppState> store) {
    return ScreenshotViewModel(
      status: store.state.screenshotState.status,
      response: store.state.screenshotState.response,
      profile: store.state.profilesState.selectedProfile,
      takeScreenshot: (ScreenshotType type) {
        store.dispatch(
          GetScreenShotOfCurrentServiceEvent(
            profile: store.state.profilesState.selectedProfile,
            screenshotType: type,
          ),
        );
      },
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScreenshotViewModel &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          profile == other.profile;

  @override
  int get hashCode => status.hashCode ^ profile.hashCode;
}
