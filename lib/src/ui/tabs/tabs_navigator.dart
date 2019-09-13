import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../message_provider.dart';
import 'tabs_navigator_viewmodel.dart';

class TabsNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return StoreConnector<AppState, TabsNavigatorViewModel>(
        distinct: true,
        converter: (store) => TabsNavigatorViewModel.fromStore(store),
        builder: (context, viewModel) {
          Color iconColor = theme.textTheme.caption.color;
          return BottomNavigationBar(
            backgroundColor: Colors.transparent,
            selectedItemColor: theme.accentColor,
            unselectedItemColor: iconColor,
            type: BottomNavigationBarType.fixed,
            onTap: viewModel.onTap,
            currentIndex: viewModel.currentIndex,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Icon(
                  Icons.folder_special,
                ),
                title: Text(
                  MessageProvider.of(context).bouquets,
                ),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Icon(
                  Icons.reorder,
                ),
                title: Text(
                  MessageProvider.of(context).services,
                ),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Icon(
                  Icons.network_check,
                ),
                title: Text(
                  MessageProvider.of(context).signal,
                ),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Icon(
                  Icons.more_horiz,
                ),
                title: Text(
                  MessageProvider.of(context).more,
                ),
              ),
            ],
          );
        });
  }
}
