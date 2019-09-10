import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/ui/common/platform_adaptive_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../message_provider.dart';
import 'bouquet_items_list_item.dart';
import 'bouquet_items_viewmodel.dart';

class BouquetItemsView extends StatefulWidget {
  const BouquetItemsView({
    Key key,
  }) : super(key: key);

  @override
  _BouquetItemsViewState createState() => _BouquetItemsViewState();
}

class _BouquetItemsViewState extends State<BouquetItemsView>
    with AutomaticKeepAliveClientMixin<BouquetItemsView> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StoreConnector<AppState, BouquetItemsViewModel>(
        distinct: true,
        converter: (store) => BouquetItemsViewModel.fromStore(store),
        onInit: (store) {
          _controller.value = _controller.value.copyWith(
            text: store.state.bouquetItemsState.searchTerm,
          );
        },
        onInitialBuild: (viewModel) {
          _controller.addListener(() {
            viewModel.onSearchTermChanged(_controller.text);
          });
        },
        builder: (context, viewModel) {
          return viewModel.status == LoadingStatus.loading
              ? const PlatformAdaptiveProgressIndicator()
              : _successContent(viewModel);
        });
  }

  @override
  bool get wantKeepAlive => true;

  Widget _successContent(BouquetItemsViewModel viewModel) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: viewModel.bouquetItems != null
            ? viewModel.bouquetItems.length + 1
            : 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 20, 16.0, 16.0),
              child: TextFormField(
                maxLines: 1,
                autocorrect: false,
                controller: _controller,
                style: TextStyle(
                    fontSize: 20, textBaseline: TextBaseline.ideographic),
                cursorRadius: Radius.circular(20),
                decoration: InputDecoration(
                  hintText: MessageProvider.of(context).searchByName,
                  hintStyle: TextStyle(fontSize: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(
                    Icons.search,
                  ),
                  suffixIcon: viewModel.hasSearchTerm
                      ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            FocusScope.of(context).requestFocus();
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              _controller.clear();
                              _controller.selection =
                                  TextSelection(baseOffset: 0, extentOffset: 0);
                            });
                          })
                      : null,
                ),
              ),
            );
          }

          index -= 1;
          return BouquetItemsListItem(
              key: Key(viewModel.bouquetItems[index].reference),
              bouquetItem: viewModel.bouquetItems[index]);
        },
      ),
    );
  }
}
