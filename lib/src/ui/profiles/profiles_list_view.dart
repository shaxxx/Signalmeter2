import 'dart:async';

import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'profile_list_item.dart';
import 'profiles_list_viewmodel.dart';

class ProfilesListView extends StatefulWidget {
  const ProfilesListView({
    Key key,
  }) : super(key: key);

  @override
  _ProfilesListViewState createState() => _ProfilesListViewState();
}

class _ProfilesListViewState extends State<ProfilesListView>
    with AutomaticKeepAliveClientMixin<ProfilesListView> {
  final animatedListKey = GlobalKey<AnimatedListState>();
  final offsetTween = Tween<Offset>(
    begin: Offset(-1.0, 0.0),
    end: Offset.zero,
  ).chain(
    CurveTween(
      curve: Curves.easeIn,
    ),
  );

  var insertedProfiles = List<IProfile>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      child: StoreConnector<AppState, ProfilesListViewModel>(
          distinct: true,
          converter: (store) {
            return ProfilesListViewModel.fromStore(store);
          },
          onInitialBuild: (viewModel) => _syncListItems(viewModel.profiles),
          onDidChange: (viewModel) => _syncListItems(viewModel.profiles),
          builder: (context, viewModel) {
            return AnimatedList(
              key: animatedListKey,
              initialItemCount: insertedProfiles.length,
              itemBuilder: (context, index, animation) {
                return SlideTransition(
                  child: ProfileListItem(
                    key: UniqueKey(),
                    profile: insertedProfiles[index],
                  ),
                  position: animation.drive(offsetTween),
                );
              },
            );
          }),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Future _syncListItems(List<IProfile> profiles1) async {
    var profiles = profiles1.toList();
    var insertedProfilesCount = insertedProfiles.length;
    List<String> newProfiles = List<String>();

    for (var profile in profiles) {
      var existingProfile =
          insertedProfiles.where((p) => p.id == profile.id).toList();
      if (existingProfile.isEmpty) {
        newProfiles.add(profile.id);
      }
    }

    for (var i = (insertedProfilesCount - 1); i >= 0; i--) {
      var existingProfile =
          profiles.where((p) => p.id == insertedProfiles[i].id).toList();
      if (existingProfile.isEmpty) {
        setState(() {
          animatedListKey.currentState.removeItem(
              i, (context, animation) => SizedBox.shrink(),
              duration: Duration(microseconds: 1));
          insertedProfiles.removeAt(i);
        });
      } else if (existingProfile.single.hashCode !=
          insertedProfiles[i].hashCode) {
        setState(() {
          animatedListKey.currentState.removeItem(
              i, (context, animation) => SizedBox.shrink(),
              duration: Duration(microseconds: 1));
          insertedProfiles.removeAt(i);
          insertedProfiles.insert(i, existingProfile.single);
          animatedListKey.currentState
              .insertItem(i, duration: Duration(microseconds: 1));
        });
      }
    }

    if (newProfiles.isNotEmpty) {
      await Future.delayed(
        Duration(
          milliseconds: insertedProfilesCount == 0 ? 500 : 0,
        ),
        () async {
          for (var i = 0; i < newProfiles.length; i++) {
            await Future.delayed(
              Duration(
                milliseconds: 200,
              ),
            );
            setState(() {
              insertedProfiles
                  .add(profiles.singleWhere((p) => p.id == newProfiles[i]));
              animatedListKey.currentState
                  .insertItem(insertedProfiles.length - 1);
            });
          }
        },
      );
    }
  }
}
