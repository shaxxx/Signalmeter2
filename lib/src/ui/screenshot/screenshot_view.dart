import 'dart:io';
import 'dart:typed_data';

import 'package:auto_orientation/auto_orientation.dart';
import 'package:enigma_signal_meter/src/constants.dart';
import 'package:enigma_signal_meter/src/message_provider.dart';
import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/messages/info_messages_events.dart';
import 'package:enigma_signal_meter/src/ui/common/platform_adaptive_progress_indicator.dart';
import 'package:enigma_signal_meter/src/utils/enigma_utils.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

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
                      if (viewModel.response?.screenshot != null) {
                        await WcFlutterShare.share(
                          sharePopupTitle: MessageProvider.of(context).share,
                          fileName: fileName + '.jpg',
                          mimeType: 'image/jpeg',
                          bytesOfFile: viewModel.response?.screenshot,
                        );
                      }
                    }),
                IconButton(
                    icon: Icon(menuIcons[saveMenuItemKey]),
                    onPressed: () async {
                      if (!await _checkPermissions()) {
                        return;
                      }
                      if (viewModel.response?.screenshot != null) {
                        final result = await ImageGallerySaver.saveImage(
                            Uint8List.fromList(viewModel.response?.screenshot));
                        if (Platform.isIOS) {
                          if (result) {
                            StoreProvider.of<AppState>(context)
                                .dispatch(ScreenshotSavedInfoMessageEvent());
                          }
                        } else {
                          if (result != null) {
                            StoreProvider.of<AppState>(context)
                                .dispatch(ScreenshotSavedInfoMessageEvent());
                          }
                        }
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
                        Uint8List.fromList(viewModel.response?.screenshot),
                      ),
                    )),
          );
        });
  }

  Future<bool> _checkPermissions() async {
    if (Platform.isAndroid) {
      return _checkPermissionsAndroid();
    }
    return _checkPermissionsIos();
  }

  Future<bool> _checkPermissionsIos() async {
    PermissionStatus permission =
        await PermissionHandler().checkPermissionStatus(PermissionGroup.photos);
    if (permission != PermissionStatus.granted) {
      Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.photos]);
      return (permissions.values.first == PermissionStatus.granted);
    }
    return true;
  }

  Future<bool> _checkPermissionsAndroid() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (permission != PermissionStatus.granted) {
      Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.storage]);
      return (permissions.values.first == PermissionStatus.granted);
    }
    return true;
  }
}
