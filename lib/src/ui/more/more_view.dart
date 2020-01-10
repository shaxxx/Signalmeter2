import 'package:enigma_signal_meter/src/constants.dart';
import 'package:enigma_signal_meter/src/i18n/messages.dart';
import 'package:enigma_signal_meter/src/message_provider.dart';
import 'package:enigma_signal_meter/src/model/menu_item.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/ui/more/more_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';

class MoreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).primaryColor.withOpacity(0.3);
    var messages = MessageProvider.of(context);
    return StoreConnector<AppState, MoreViewModel>(
        distinct: true,
        converter: (store) {
          return MoreViewModel.fromStore(store, messages);
        },
        builder: (context, viewModel) {
          return Container(
            padding: EdgeInsets.all(20),
            child: GridView.extent(
              maxCrossAxisExtent: 160,
              children:
                  buildItems(context, viewModel, backgroundColor, messages),
            ),
          );
        });
  }

  List<Widget> buildItems(BuildContext context, MoreViewModel viewModel,
      Color backgroundColor, Messages messages) {
    var items = <Widget>[];
    for (var item in viewModel.menuItems) {
      items.add(
        buildCard(
          backgroundColor,
          item,
          () async {
            if (item.key == restartMenuItemKey) {
              if (!await askRebootDialog(context, item, viewModel, messages)) {
                return;
              }
            }
            viewModel.onSelected(item);
          },
        ),
      );
    }
    return items;
  }

  Card buildCard(Color backgroundColor, MenuItem item, void Function() onTap) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              item.icon,
              size: 40,
            ),
            Text(
              item.title,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> askRebootDialog(BuildContext context, MenuItem menuItem,
      MoreViewModel viewModel, Messages messages) async {
    var result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            messages.titleQuestion.toUpperCase(),
          ),
          content: Text(
            messages.questionRestartGui(viewModel.profileName),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                viewModel.onSelected(menuItem);
                Navigator.pop(context, true);
              },
              child: Text(
                messages.confirm.toUpperCase(),
              ),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }
}
