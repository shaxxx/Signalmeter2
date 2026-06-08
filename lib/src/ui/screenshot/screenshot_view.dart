import 'dart:typed_data';

import 'package:enigma_signal_meter/src/constants.dart';
import 'package:enigma_signal_meter/src/message_provider.dart';
import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/messages/info_messages_events.dart';
import 'package:enigma_signal_meter/src/ui/common/platform_adaptive_progress_indicator.dart';
import 'package:enigma_signal_meter/src/utils/enigma_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gal/gal.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';

import 'screenshot_viewmodel.dart';

class ScreenshotView extends StatefulWidget {
  @override
  _ScreenshotViewState createState() => _ScreenshotViewState();
}

class _ScreenshotViewState extends State<ScreenshotView> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ScreenshotViewModel>(
        distinct: true,
        converter: (store) {
          return ScreenshotViewModel.fromStore(store);
        },
        onInitialBuild: (viewmodel) =>
            viewmodel.takeScreenshot(ScreenshotType.all),
        builder: (context, viewModel) {
          var fileName = EnigmaUtils.unixTimeStamp();
          return Scaffold(
            appBar: AppBar(
              title: Text(MessageProvider.of(context).actionScreenshot),
              backgroundColor: Colors.black,
              actions: <Widget>[
                IconButton(
                  icon: Icon(menuIcons[screenshotMenuItemKey]),
                  onPressed: () => viewModel.takeScreenshot(ScreenshotType.all),
                ),
                IconButton(
                    icon: Icon(menuIcons[shareMenuItemKey]),
                    onPressed: () async {
                      final bytes = viewModel.response.screenshot;
                      await SharePlus.instance.share(
                        ShareParams(
                          files: [
                            XFile.fromData(
                              Uint8List.fromList(bytes),
                              name: fileName + '.jpg',
                              mimeType: 'image/jpeg',
                            )
                          ],
                          subject: MessageProvider.of(context).share,
                        ),
                      );
                                        }),
                IconButton(
                    icon: Icon(menuIcons[saveMenuItemKey]),
                    onPressed: () async {
                      final bytes = viewModel.response.screenshot;
                      try {
                        if (!await Gal.hasAccess()) {
                          await Gal.requestAccess();
                        }
                        await Gal.putImageBytes(
                          Uint8List.fromList(bytes),
                          name: fileName,
                        );
                        StoreProvider.of<AppState>(context)
                            .dispatch(ScreenshotSavedInfoMessageEvent());
                      } on GalException catch (_) {
                        // permission denied or save failed; leave UI unchanged
                      }
                    }),
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
                        Uint8List.fromList(
                            viewModel.response.screenshot ?? <int>[]),
                      ),
                    )),
          );
        });
  }
}
