import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../constants.dart';
import 'bouquet_items_list_item_viewmodel.dart';

class BouquetItemsListItem extends StatelessWidget {
  final IBouquetItem bouquetItem;

  const BouquetItemsListItem({
    Key key,
    @required this.bouquetItem,
  })  : assert(bouquetItem != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BouquetItemsListItemViewModel>(
      distinct: true,
      converter: (store) =>
          BouquetItemsListItemViewModel.fromStore(store, bouquetItem),
      builder: (context, viewModel) {
        return viewModel.isMarker
            ? _buildMarkerView(context, viewModel)
            : _buildServiceView(context, viewModel);
      },
    );
  }

  Widget _buildServiceView(
    BuildContext context,
    BouquetItemsListItemViewModel viewModel,
  ) {
    var theme = Theme.of(context);
    return Row(
      children: <Widget>[
        Flexible(
          child: InkWell(
            onTap: viewModel.onTap,
            child: Container(
              height: listItemHeight,
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(
                  const Radius.circular(10.0),
                ),
                color: viewModel.selected
                    ? theme.accentColor.withOpacity(0.3)
                    : theme.primaryColor.withOpacity(0.3),
                border: Border.all(color: theme.accentColor.withOpacity(0.3)),
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20),
              child: Text(
                '${viewModel.name}',
                style: const TextStyle(fontSize: 20.0, color: Colors.white),
                overflow: TextOverflow.clip,
                maxLines: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMarkerView(
      BuildContext context, BouquetItemsListItemViewModel viewModel) {
    return Container(
      height: listItemHeight,
      margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(
          const Radius.circular(10.0),
        ),
        color: Theme.of(context).primaryColor.withOpacity(0.7),
        border: Border.all(color: Theme.of(context).accentColor),
      ),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 10),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.attach_file,
              size: 30,
            ),
          ),
          Flexible(
            child: Text(
              '${viewModel.name}',
              style: const TextStyle(fontSize: 20.0, color: Colors.white),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
