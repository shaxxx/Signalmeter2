import 'package:enigma_signal_meter/src/constants.dart';
import 'package:enigma_signal_meter/src/model/menu_item.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../message_provider.dart';
import 'tabs_appbar_viewmodel.dart';

class TabsAppBarView {
  static AppBar buildAppBar(Color backgroundColor) {
    return AppBar(
      title: _buildTitle(),
      backgroundColor: backgroundColor,
      actions: _buildMenu(),
    );
  }

  static Widget _buildTitle() {
    return Builder(builder: (context) {
      return StoreConnector<AppState, TabsAppBarViewModel>(
        distinct: true,
        converter: (store) {
          return TabsAppBarViewModel.fromStore(
              store, MessageProvider.of(context));
        },
        builder: (context, viewModel) {
          return Text(viewModel.title);
        },
      );
    });
  }

  static List<Widget> _buildMenu() {
    List<Widget> _actions = List<Widget>();
    _actions.add(Builder(builder: (context) {
      return StoreConnector<AppState, TabsAppBarViewModel>(
        distinct: true,
        converter: (store) {
          return TabsAppBarViewModel.fromStore(
              store, MessageProvider.of(context));
        },
        builder: (context, viewModel) {
          if (viewModel.menuItems == null || viewModel.menuItems.length == 0) {
            return SizedBox.shrink();
          }
          var actions = _visibleActions(viewModel);
          if (viewModel.menuItems.length > viewModel.visibleItemsCount) {
            actions.add(_overflowMenu(viewModel));
          }
          return Row(
            children: actions,
          );
        },
      );
    }));
    return _actions;
  }

  static List<Widget> _visibleActions(TabsAppBarViewModel viewModel) {
    var icons = List<Widget>();
    viewModel.menuItems.take(viewModel.visibleItemsCount).forEach((menuItem) {
      icons.add(
        Builder(
          builder: (BuildContext context) {
            return StoreConnector<AppState, TabsAppBarViewModel>(
              distinct: true,
              converter: (store) {
                return TabsAppBarViewModel.fromStore(
                    store, MessageProvider.of(context));
              },
              builder: (context, viewModel) {
                var selectionHandler = _handleItemSelection(
                  context,
                  viewModel,
                );
                return IconButton(
                  icon: Icon(menuItem.icon),
                  onPressed: () => selectionHandler(menuItem),
                );
              },
            );
          },
        ),
      );
    });
    return icons;
  }

  static Widget _overflowMenu(TabsAppBarViewModel viewModel) {
    return Builder(
      builder: (BuildContext context) {
        var selectionHandler = _handleItemSelection(context, viewModel);
        return PopupMenuButton<MenuItem>(
          onSelected: selectionHandler,
          itemBuilder: (BuildContext context) {
            return viewModel.menuItems
                .skip(viewModel.visibleItemsCount)
                .map((MenuItem menuItem) {
              return PopupMenuItem<MenuItem>(
                value: menuItem,
                child: Text(menuItem.title),
              );
            }).toList();
          },
        );
      },
    );
  }

  static void Function(MenuItem) _handleItemSelection(
      BuildContext context, TabsAppBarViewModel viewmodel) {
    return (menuItem) {
      if (menuItem.key == restartMenuItemKey) {
        showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  MessageProvider.of(context).titleQuestion.toUpperCase(),
                ),
                content: Text(
                  MessageProvider.of(context)
                      .questionRestartGui(viewmodel.profileName),
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      viewmodel.onSelected(menuItem);
                      Navigator.pop(context, true);
                    },
                    child: Text(
                      MessageProvider.of(context).confirm.toUpperCase(),
                    ),
                  ),
                ],
              );
            });
      } else {
        viewmodel.onSelected(menuItem);
      }
    };
  }
}
