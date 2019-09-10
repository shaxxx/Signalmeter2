import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/profiles/profiles_events.dart';
import 'package:enigma_signal_meter/src/utils/preference_manager.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';

class ProfilesMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoadProfilesEvent) {
      Logger.root.fine(
          "Dispatching ProfilesStatusChangedEvent from ProfilesMiddleware as response to LoadProfilesEvent");
      store.dispatch(ProfilesStatusChangedEvent(LoadingStatus.loading));
      await _loadProfiles(store, action);
    } else if (action is LoadProfilesErrorEvent) {
      Logger.root.fine(
          "Dispatching ProfilesStatusChangedEvent from ProfilesMiddleware as response to LoadProfilesErrorEvent");
      store.dispatch(ProfilesStatusChangedEvent(LoadingStatus.error));
    } else if (action is LoadProfilesSuccessEvent) {
      Logger.root.fine(
          "Dispatching ProfilesStatusChangedEvent from ProfilesMiddleware as response to LoadProfilesSuccessEvent");
      store.dispatch(ProfilesStatusChangedEvent(LoadingStatus.success));
      if (action.profiles.length == 1) {
        Logger.root.fine(
            "Dispatching ProfileSelectedEvent from ProfilesMiddleware as response to ProfilesStatusChangedEvent");
        store.dispatch(ProfileSelectedEvent(action.profiles.first));
      }
    }
    next(action);

    if (action is ProfileSaveEvent) {
      await PreferenceManager.saveProfiles(store.state.profilesState.profiles);
    } else if (action is ProfileDeletedEvent) {
      await PreferenceManager.saveProfiles(store.state.profilesState.profiles);
      Logger.root.fine(
          "Dispatching ProfileSelectedEvent from ProfilesMiddleware as response to ProfileDeletedEvent");
      store.dispatch(ProfileSelectedEvent(null));
    }
  }

  Future _loadProfiles(Store<AppState> store, LoadProfilesEvent action) async {
    try {
      var stopwatch = Stopwatch();
      stopwatch.start();
      var profiles = await PreferenceManager.loadProfiles();
      stopwatch.stop();
      store.dispatch(LoadProfilesSuccessEvent(
          responseDuration: stopwatch.elapsed, profiles: profiles));
    } catch (e) {
      store.dispatch(LoadProfilesErrorEvent(error: e));
    }
  }
}
