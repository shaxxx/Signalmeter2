import 'dart:typed_data';

import 'package:auto_orientation/auto_orientation.dart';
import 'package:enigma_signal_meter/src/constants.dart';
import 'package:enigma_signal_meter/src/message_provider.dart';
import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/ui/common/platform_adaptive_progress_indicator.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:photo_view/photo_view.dart';

import 'screenshot_viewmodel.dart';

class ScreenshotView extends StatefulWidget {
  @override
  _ScreenshotViewState createState() => _ScreenshotViewState();
}

class _ScreenshotViewState extends State<ScreenshotView> {
  @override
  void initState() {
    super.initState();
    AutoOrientation.fullAutoMode();
  }

  @override
  void dispose() {
    AutoOrientation.portraitAutoMode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ScreenshotViewModel>(
        distinct: true,
        converter: (store) {
          return ScreenshotViewModel.fromStore(store);
        },
        // onInit: (store) => store.dispatch(
        //       GetScreenShotOfCurrentServiceEvent(
        //         profile: store.state.profilesState.selectedProfile,
        //         screenshotType: ScreenshotType.all,
        //       ),
        //     ),
        onInitialBuild: (viewmodel) =>
            viewmodel.takeScreenshot(ScreenshotType.all),
        builder: (context, viewModel) {
          return Scaffold(
            appBar: AppBar(
              title: Text(MessageProvider.of(context).actionScreenshot),
              backgroundColor: Colors.black,
              actions: <Widget>[
                IconButton(
                  icon: Icon(menuIcons[screenshotMenuItemKey]),
                  onPressed: () => viewModel.takeScreenshot(ScreenshotType.all),
                )
              ],
            ),
            body: viewModel.status == LoadingStatus.loading ||
                    viewModel.status == LoadingStatus.idle
                ? const PlatformAdaptiveProgressIndicator()
                : Container(
                    color: Colors.black,
                    child: PhotoView(
                      minScale: PhotoViewComputedScale.contained * 0.8,
                      imageProvider: MemoryImage(
                        Uint8List.fromList(viewModel.response?.screenshot),
                      ),
                    )),
          );
        });
  }
}
