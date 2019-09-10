import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/ui/common/platform_adaptive_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'bouquets_list_item.dart';
import 'bouquets_viewmodel.dart';

class BouquetsView extends StatefulWidget {
  const BouquetsView({
    Key key,
  }) : super(key: key);

  @override
  _BouquetsViewState createState() => _BouquetsViewState();
}

class _BouquetsViewState extends State<BouquetsView>
    with AutomaticKeepAliveClientMixin<BouquetsView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StoreConnector<AppState, BouquetsViewModel>(
        distinct: true,
        converter: (store) => BouquetsViewModel.fromStore(store),
        builder: (context, viewModel) {
          return viewModel.status == LoadingStatus.loading
              ? const PlatformAdaptiveProgressIndicator()
              : Scrollbar(
                  child: ListView.builder(
                    itemCount: viewModel.bouquets != null
                        ? viewModel.bouquets.length
                        : 0,
                    itemBuilder: (BuildContext context, int index) {
                      return BouquetsListItem(
                          bouquet: viewModel.bouquets[index]);
                    },
                  ),
                );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
