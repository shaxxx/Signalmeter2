import 'package:enigma_signal_meter/src/app_routes.dart';
import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/ui/signal/remote_buttons_view.dart';
import 'package:enigma_signal_meter/src/ui/signal/signal_chart_view.dart';
import 'package:enigma_signal_meter/src/ui/signal/signal_circular_progress_view.dart';
import 'package:enigma_signal_meter/src/ui/signal/signal_progressbar_view.dart';
import 'package:enigma_signal_meter/src/ui/signal/signal_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'current_service_view.dart';

class SignalView extends StatefulWidget {
  @override
  _SignalViewState createState() => _SignalViewState();
}

class _SignalViewState extends State<SignalView> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SignalViewModel>(
      distinct: true,
      converter: (store) => SignalViewModel.fromStore(store),
      builder: (context, viewModel) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CurrentServiceView(),
              RemoteButtonsView(),
              InkWell(
                onTap: viewModel.onCycleView,
                child: viewModel.signalView == SignalViewEnum.Linear
                    ? SignalProgressbarView()
                    : SignalCircularProgressView(),
              ),
              InkWell(
                child: SignalChartView(),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.signalChart,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
