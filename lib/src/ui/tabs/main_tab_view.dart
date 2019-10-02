import 'dart:ui';

import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/ui/bouquets/bouquets_view.dart';
import 'package:enigma_signal_meter/src/ui/common/scaffold_background.dart';
import 'package:enigma_signal_meter/src/ui/more/more_view.dart';
import 'package:enigma_signal_meter/src/ui/services/bouquet_items_view.dart';
import 'package:enigma_signal_meter/src/ui/signal/signal_view.dart';
import 'package:enigma_signal_meter/src/ui/tabs/tabs_navigator.dart';
import 'package:enigma_signal_meter/src/utils/tts_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'main_tab_viewmodel.dart';
import 'tabs_appbar_view.dart';

class MainTabView extends StatefulWidget {
  @override
  _MainTabViewState createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver, RouteAware {
  PageController controller;
  int goToPage = -1;
  bool isAnimating = false;
  MainTabViewModel _viewModel;
  RouteObserver<PageRoute> _routeObserver;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    controller = PageController(
      initialPage: 0,
      keepPage: false,
    );
    controller.addListener(_handleTabSelection);
  }

  bool ttsInitCalled = false;

  @override
  void dispose() {
    _viewModel?.onActiveChanged(false);
    WidgetsBinding.instance.removeObserver(this);
    _routeObserver.unsubscribe(this);
    controller.dispose();
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

  void _handleTabSelection() {
    if (_viewModel == null) return;
    if (!isAnimating) {
      var store = StoreProvider.of<AppState>(context);
      bool isControllerOnActiveTab =
          store.state.tabsState.activeTab.index == controller.page.round();
      if (!isControllerOnActiveTab) {
        _viewModel.onTabSelected(TabPagesEnum.values[controller.page.round()]);
      }
    }
  }

  Future selectTab(AppState state) async {
    if (state.tabsState.activeTab.index != goToPage) {
      goToPage = state.tabsState.activeTab.index;
      await _animateToPage();
    }
  }

  Future _animateToPage() async {
    if (controller.positions == null || controller.positions.isEmpty) {
      return;
    }
    //uncoment to have pageview animate to page
    //if (isAnimating) {
    controller.jumpToPage(goToPage);
    isAnimating = false;
    return;
    //}
    // isAnimating = true;
    // int page = goToPage;
    // await controller.animateToPage(
    //   page,
    //   duration: Duration(milliseconds: 500),
    //   curve: Curves.linear,
    // );
    // isAnimating = false;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MainTabViewModel>(
      distinct: true,
      converter: (store) {
        return MainTabViewModel.fromStore(store);
      },
      onInit: (store) {
        _routeObserver = store.state.globalState.routeObserver;
        _routeObserver.subscribe(this, ModalRoute.of(context));
        store.onChange.listen(selectTab);
      },
      onInitialBuild: (vm) {
        vm.onActiveChanged(true);
      },
      onDidChange: (vm) {
        _viewModel = vm;
        if (vm.shouldInitializeTts && !ttsInitCalled) {
          ttsInitCalled = true;
          TtsUtils.setSpeakErrorHandler(vm.onSpeakError);
          TtsUtils.setSpeakEndHandler(vm.onSpeakEnd);
          TtsUtils.setLanguage(Localizations.localeOf(context))
              .then((result) => TtsUtils.configure())
              .then((result) => vm.onTtsInitialized())
              .catchError(vm.onTtsInitError);
        }
      },
      builder: (context, viewModel) {
        return ScaffoldBackground(
          appBar: TabsAppBarView.buildAppBar(
              Theme.of(context).primaryColor.withOpacity(0.6)),
          bottomNavigationBar: viewModel.showNavigator ? TabsNavigator() : null,
          child: PageView(
            controller: controller,
            physics: viewModel.scrollable
                ? AlwaysScrollableScrollPhysics()
                : NeverScrollableScrollPhysics(),
            children: [
              BouquetsView(),
              BouquetItemsView(),
              SignalView(),
              MoreView()
            ],
          ),
        );
      },
    );
  }
}
