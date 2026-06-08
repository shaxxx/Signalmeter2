import 'dart:io';

import 'package:enigma_signal_meter/src/message_provider.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/ui/profiles/profiles_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:showcaseview/showcaseview.dart';

import 'profiles_list_view.dart';

GlobalKey fabIosShowcaseKey = GlobalKey();

class ProfilesView extends StatelessWidget {
  const ProfilesView({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfilesViewModel>(
        distinct: true,
        converter: (store) {
          return ProfilesViewModel.fromStore(store);
        },
        builder: (context, viewModel) {
          var theme = Theme.of(context);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: double.infinity,
                        child: ProfilesListView(),
                      ),
                    )
                  ],
                ),
              ),
              Showcase(
                key: fabIosShowcaseKey,
                title: MessageProvider.of(context).addProfileShowcaseTitle,
                description: MessageProvider.of(context).addProfileShowcaseText,
                targetShapeBorder: CircleBorder(),
                showArrow: true,
                movingAnimationDuration: Duration(milliseconds: 1500),
                overlayColor: Colors.blueGrey,
                overlayOpacity: 0,
                onTargetClick: () => viewModel.addProfile?.call(),
                disposeOnTap: true,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Platform.isIOS
                      ? Container(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.secondary
                                .withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          //alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(vertical: 15),
                          child: TextButton(
                            onPressed: () async {
                              await viewModel.addProfile?.call();
                            },
                            child: Text(
                              MessageProvider.of(context)
                                  .actionAddProfile
                                  .toUpperCase(),
                              style: TextStyle(
                                color: theme.textTheme.titleMedium?.color,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ),
              ),
            ],
          );
        });
  }
}
