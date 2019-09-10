import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/ui/common/circular_progress_view.dart';
import 'package:enigma_signal_meter/src/ui/common/subtitle_panel_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../message_provider.dart';
import 'signal_circular_progress_viewmodel.dart';

class SignalCircularProgressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SignalCircularProgressViewModel>(
      distinct: true,
      converter: (store) => SignalCircularProgressViewModel.fromStore(
        store,
        MessageProvider.of(context),
      ),
      builder: (context, viewModel) {
        var screenSize =
            StoreProvider.of<AppState>(context).state.profilesState.screenSize;
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
