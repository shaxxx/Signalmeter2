import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/ui/common/circular_progress_view.dart';
import 'package:enigma_signal_meter/src/ui/common/subtitle_panel_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../message_provider.dart';
import 'signal_circular_progress_viewmodel.dart';

class SignalCircularProgressView extends StatelessWidget {
  const SignalCircularProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SignalCircularProgressViewModel>(
      distinct: true,
      converter: (store) => SignalCircularProgressViewModel.fromStore(
        store,
        MessageProvider.of(context),
      ),
      builder: (context, viewModel) {
        // Read the size live from MediaQuery rather than from a value cached
        // once at startup. The cached globalState.screenSize is captured in
        // HomeView.onInit, which in release builds can run before the platform
        // reports window metrics, yielding Size.zero. That zero is stored
        // permanently and collapses the circular indicator to 0x0 (invisible)
        // — the cause of the "circle never appears without a debugger" bug.
        var screenSize = MediaQuery.sizeOf(context);
        return GestureDetector(
          child: viewModel.hasInfo
              ? _circularProgressView(
                  viewModel, viewModel.isBerView, screenSize)
              : _noSignalView(context),
        );
      },
    );
  }

  Widget _circularProgressView(
    SignalCircularProgressViewModel viewModel,
    bool isBerView,
    Size screenSize,
  ) {
    if (isBerView) {
      return CircularProgressView(
        stringValue: viewModel.stringValue,
        doubleValue: viewModel.doubleValue,
        footerString: viewModel.footerValue,
        screenSize: screenSize,
        colors: [Colors.orange, Colors.red],
        stops: [0.0, 0.2],
      );
    } else {
      return CircularProgressView(
        stringValue: viewModel.stringValue,
        doubleValue: viewModel.doubleValue,
        footerString: viewModel.footerValue,
        screenSize: screenSize,
      );
    }
  }

  Widget _noSignalView(BuildContext context) {
    return Center(
      child: SubtitlePanelView(
        child: Padding(
          padding: EdgeInsets.only(bottom: 50, top: 50),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                MessageProvider.of(context).noInformation,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
