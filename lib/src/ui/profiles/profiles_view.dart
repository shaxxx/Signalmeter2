import 'dart:io';

import 'package:auto_orientation/auto_orientation.dart';
import 'package:enigma_signal_meter/src/message_provider.dart';
import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/profiles/profiles_events.dart';
import 'package:enigma_signal_meter/src/ui/common/disappearing_fab.dart';
import 'package:enigma_signal_meter/src/ui/common/scaffold_background.dart';
import 'package:enigma_signal_meter/src/ui/profiles/profiles_viewmodel.dart';
import 'package:enigma_signal_meter/src/utils/message_display_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../constants.dart';
import 'profiles_list_view.dart';

class ProfilesView extends StatefulWidget {
  @override
  _ProfilesViewState createState() => new _ProfilesViewState();
}

class _ProfilesViewState extends State<ProfilesView> with RouteAware {
  ProfilesViewModel _viewModel;

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
        .routeObserver
        .subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    StoreProvider.of<AppState>(context).state.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    if (_viewModel != null) {
      _viewModel.onPop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfilesViewModel>(
      distinct: true,
      converter: (store) {
        return ProfilesViewModel.fromStore(store);
      },
      onInit: (store) {
        store.dispatch(SetScreenSizeEvent(MediaQuery.of(context).size));
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
          appBar: AppBar(
            title: Text(MessageProvider.of(context).appName),
            backgroundColor: Colors.transparent,
            actions: <Widget>[
              IconButton(
                  icon: Icon(menuIcons[aboutMenuItemKey]),
                  onPressed: () => viewModel.openAbout()),
            ],
          ),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        child: ProfilesListView(),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Platform.isIOS
                    ? SizedBox(
                        width: 160,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(vertical: 15),
                          child: InkWell(
                            onTap: () async {
                              await viewModel.addProfile();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              constraints: BoxConstraints.expand(
                                height: 40,
                              ),
                              child: Text(
                                MessageProvider.of(context)
                                    .actionAddProfile
                                    .toUpperCase(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              ),
            ],
          ),
        );
      },
    );
  }
}
