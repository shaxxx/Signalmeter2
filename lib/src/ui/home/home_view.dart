import 'dart:io';

import 'package:auto_orientation/auto_orientation.dart';
import 'package:enigma_signal_meter/src/message_provider.dart';
import 'package:enigma_signal_meter/src/model/application_settings.dart';
import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/global/global_events.dart';
import 'package:enigma_signal_meter/src/ui/common/backdrop.dart';
import 'package:enigma_signal_meter/src/ui/common/disappearing_fab.dart';
import 'package:enigma_signal_meter/src/ui/common/scaffold_background.dart';
import 'package:enigma_signal_meter/src/ui/profiles/profiles_view.dart';
import 'package:enigma_signal_meter/src/ui/settings/settings_view.dart';
import 'package:enigma_signal_meter/src/utils/message_display_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'home_viewmodel.dart';

const Duration _kFrontLayerSwitchDuration = Duration(milliseconds: 300);

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with RouteAware {
  HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    AutoOrientation.portraitAutoMode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    StoreProvider.of<AppState>(context)
        .state
        .globalState
        .routeObserver
        .subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    StoreProvider.of<AppState>(context)
        .state
        .globalState
        .routeObserver
        .unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    if (_viewModel != null) {
      _viewModel.onPop();
    }
  }

  ValueChanged<ApplicationSettings> onSettingsChanged;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) {
        return HomeViewModel.fromStore(store);
      },
      onInit: (store) {
        store.dispatch(SetScreenSizeEvent(MediaQuery.of(context).size));
        onSettingsChanged = (applicationSettings) {
          store.dispatch(ApplicationSettingsChangedEvent(applicationSettings));
        };
      },
      onInitialBuild: (vm) => {
        _viewModel = vm,
      },
      onDidChange: (viewModel) async {
        _viewModel = viewModel;
        await MessageDisplayHandler.displayMessages(
          context: context,
          viewModel: viewModel,
        );
      },
      builder: (context, viewModel) {
        return ScaffoldBackground(
          floatingActionButton: Platform.isAndroid
              ? DisappearingFab(
                  child: FloatingActionButton(
                    onPressed: viewModel.addProfile,
                    child: Icon(Icons.add),
                  ),
                  finalStateVisible: viewModel.connectionState ==
                      ConnectionStatusEnum.disconnected,
                )
              : null,
          child: Backdrop(
            backTitle: Text(MessageProvider.of(context).options),
            backLayer: SettingsView(onSettingsChanged: onSettingsChanged),
            frontAction: AnimatedSwitcher(
              duration: _kFrontLayerSwitchDuration,
            ),
            frontTitle: const Text('SignalMeter'),
            frontLayer: AnimatedSwitcher(
              duration: _kFrontLayerSwitchDuration,
              child: ProfilesView(),
            ),
          ),
        );
      },
    );
  }
}
