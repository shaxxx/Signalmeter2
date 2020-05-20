import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/ui/common/custom_flat_button.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_flip_view/flutter_flip_view.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../message_provider.dart';
import 'profile_list_item_viewmodel.dart';

class ProfileListItem extends StatefulWidget {
  final IProfile profile;

  const ProfileListItem({
    Key key,
    @required this.profile,
  }) : super(key: key);

  @override
  _ProfileListItemState createState() => _ProfileListItemState();
}

class _ProfileListItemState extends State<ProfileListItem>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _curvedAnimation;
  bool visibleCardA;

  @override
  void initState() {
    super.initState();

    visibleCardA = true;
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _flip(bool reverse) {
    if (_animationController.isAnimating) return;
    if (reverse) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return StoreConnector<AppState, ProfileListItemViewModel>(
        distinct: true,
        converter: (store) =>
            ProfileListItemViewModel.fromStore(store, widget.profile),
        builder: (context, viewModel) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: viewModel.selected ? 121 : 90,
            alignment: Alignment.topLeft,
            child: Card(
              elevation: 2,
              color: viewModel.selected
                  ? theme.accentColor.withOpacity(0.3)
                  : theme.primaryColor.withOpacity(0.3),
              child: _buildRow(context, viewModel),
            ),
          );
        });
  }

  Widget _buildRow(BuildContext context, ProfileListItemViewModel viewModel) {
    if (viewModel.isClickable) {
      return _buildClickableRow(viewModel);
    } else if (viewModel.selected) {
      return buildRowB(context, viewModel);
    }
    return buildRowA(context, viewModel);
  }

  Widget _buildClickableRow(ProfileListItemViewModel viewModel) {
    if (viewModel.selected) {
      _animationController.forward();
    } else {
      _animationController.reset();
    }

    return InkWell(
      onTap: () {
        viewModel.onTap();
        if (!viewModel.selected) {
          _flip(visibleCardA);
          visibleCardA = !visibleCardA;
        }
      },
      child: FlipView(
        animationController: _curvedAnimation,
        front: buildRowA(context, viewModel),
        back: buildRowB(context, viewModel),
        goBackDirection: AxisDirection.down,
        goFrontDirection: AxisDirection.up,
      ),
    );
  }

  Widget buildRowA(BuildContext context, ProfileListItemViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 10, left: 20, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildItemIcon(viewModel, Icons.tv),
              _buildItemInfo(context, viewModel),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildRowB(BuildContext context, ProfileListItemViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 10, left: 20, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildItemIcon(viewModel, Icons.power_settings_new),
              _buildItemInfo(context, viewModel),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              viewModel.connectButtonEnabled
                  ? _connectButton(viewModel)
                  : _disconnectButton(viewModel),
              _editButton(viewModel),
              _deleteButton(viewModel),
            ],
          ),
        ),
        _progressBar(viewModel),
      ],
    );
  }

  Widget _buildItemInfo(
      BuildContext context, ProfileListItemViewModel viewModel) {
    var theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(
          child: Text(
            viewModel.name,
            style: theme.textTheme.subtitle1,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Flexible(
          child: Text(
            viewModel.address,
            style: theme.textTheme.bodyText2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildItemIcon(ProfileListItemViewModel viewModel, IconData icon) {
    return InkWell(
      onTap: viewModel.selected && viewModel.connectButtonEnabled
          ? viewModel.onConnect
          : null,
      child: Container(
        padding: EdgeInsets.only(right: 20),
        child: Icon(
          icon,
          size: 60,
        ),
      ),
    );
  }

  Widget _connectButton(ProfileListItemViewModel viewModel) {
    if (viewModel.connectButtonEnabled) {
      return CustomFlatButton(
        child: Text(
          MessageProvider.of(context).actionConnect.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        onPressed: viewModel.onConnect,
      );
    }
    return SizedBox.shrink();
  }

  Widget _disconnectButton(ProfileListItemViewModel viewModel) {
    if (viewModel.disconnectButtonEnabled) {
      return CustomFlatButton(
        child: Text(
          MessageProvider.of(context).actionDisconnect.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        onPressed: viewModel.onDisconnect,
      );
    }
    return SizedBox.shrink();
  }

  Widget _editButton(ProfileListItemViewModel viewModel) {
    return CustomFlatButton(
      child: Text(
        MessageProvider.of(context).actionEdit.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      onPressed: viewModel.onEdit,
    );
  }

  Future<bool> _showQuestionDialog(String text) async {
    return await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  MessageProvider.of(context).titleQuestion,
                ),
                content: Text(
                  text,
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text(
                      MessageProvider.of(context).confirm.toUpperCase(),
                    ),
                  ),
                ],
              );
            }) ??
        false;
  }

  Widget _deleteButton(ProfileListItemViewModel viewModel) {
    return CustomFlatButton(
      child: Text(
        MessageProvider.of(context).actionDelete.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      onPressed: viewModel.deleteButtonEnabled
          ? () async {
              var dialogResult = await _showQuestionDialog(
                  MessageProvider.of(context)
                      .questionDeleteProfile(viewModel.name));
              if (dialogResult) {
                viewModel.onDelete();
              }
            }
          : null,
    );
  }

  Widget _progressBar(ProfileListItemViewModel viewModel) {
    if (viewModel.progressBarEnabled) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: LinearProgressIndicator(),
      );
    }
    return SizedBox.shrink();
  }
}
