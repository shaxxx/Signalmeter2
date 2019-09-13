import 'package:auto_orientation/auto_orientation.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/ui/signal/signal_chart_full_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:enigma_signal_meter/src/ui/signal/signal_chart_view.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../constants.dart';

class SignalChartFullScreen extends StatefulWidget {
  @override
  _SignalChartFullScreenState createState() => _SignalChartFullScreenState();
}

class _SignalChartFullScreenState extends State<SignalChartFullScreen>
    with WidgetsBindingObserver, RouteAware {
  SignalChartFullScreenViewModel _viewModel;
  RouteObserver<PageRoute> _routeObserver;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    // ]);
    AutoOrientation.landscapeAutoMode();
  }

  @override
  void dispose() {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    AutoOrientation.portraitAutoMode();
    _viewModel.onActiveChanged(false);
    WidgetsBinding.instance.removeObserver(this);
    _routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_viewModel != null) {
      _viewModel.onActiveChanged(state == AppLifecycleState.resumed);
    }
  }

  // Called when the top route has been popped off, and the current route shows up.
  void didPopNext() {
    if (_viewModel != null) {
      _viewModel.onActiveChanged(true);
    }
  }

  // Called when the current route has been pushed.
  void didPush() {
    if (_viewModel != null) {
      _viewModel.onActiveChanged(true);
    }
  }

  // Called when the current route has been popped off.
  void didPop() {
    if (_viewModel != null) {
      _viewModel.onActiveChanged(false);
    }
  }

  // Called when a new route has been pushed, and the current route is no longer visible.
  void didPushNext() {
    if (_viewModel != null) {
      _viewModel.onActiveChanged(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SignalChartFullScreenViewModel>(
      distinct: true,
      converter: (store) {
        return SignalChartFullScreenViewModel.fromStore(store);
      },
      onInit: (store) {
        _routeObserver = store.state.routeObserver;
        _routeObserver.subscribe(this, ModalRoute.of(context));
      },
      onInitialBuild: (vm) {
        _viewModel = vm;
        _viewModel.onActiveChanged(true);
      },
      onDidChange: (vm) {
        _viewModel = vm;
      },
      builder: (context, viewModel) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundAsset),
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: InkWell(
                child: SignalChartView(),
                onTap: () => Navigator.pop(context),
              ),
            ),
          ),
        );
      },
    );
  }
}
