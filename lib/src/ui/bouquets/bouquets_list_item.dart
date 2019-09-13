import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../constants.dart';
import 'bouquets_list_item_viewmodel.dart';

class BouquetsListItem extends StatelessWidget {
  final IBouquetItemBouquet bouquet;

  const BouquetsListItem({
    Key key,
    @required this.bouquet,
  })  : assert(bouquet != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return StoreConnector<AppState, BouquetsListItemViewModel>(
      distinct: true,
      converter: (store) => BouquetsListItemViewModel.fromStore(store, bouquet),
      builder: (context, viewModel) {
        return Row(
          children: <Widget>[
            Flexible(
              child: InkWell(
                onTap: viewModel.onTap,
                child: Container(
                  height: listItemHeight,
                  margin:
                      EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    color: viewModel.selected
                        ? theme.accentColor.withOpacity(0.3)
                        : theme.primaryColor.withOpacity(0.3),
                    border:
                        Border.all(color: theme.accentColor.withOpacity(0.3)),
                  ),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      '${viewModel.name}',
                      style:
                          const TextStyle(fontSize: 20.0, color: Colors.white),
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
