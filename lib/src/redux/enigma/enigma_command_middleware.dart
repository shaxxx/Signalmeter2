import 'package:enigma_signal_meter/src/model/enigma_web_exception.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/utils/enigma_api.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:redux/redux.dart';

import 'enigma_command_events.dart';

class EnigmaCommandMiddleware extends MiddlewareClass<AppState> {
  final IWebRequester requester;

  EnigmaCommandMiddleware(this.requester);

  @override
  void call(Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    if (action is WakeUpEvent) {
      await _wakeUp(store, action);
    } else if (action is SentToSleepEvent) {
      await _sleep(store, action);
    } else if (action is GetBouquetsEvent) {
      await _getBouquets(store, action);
    } else if (action is GetBouquetItemsEvent) {
      await _getServices(store, action);
    } else if (action is GetCurrentServiceEvent) {
      await _getCurrentService(store);
    } else if (action is ChangeServiceEvent) {
      await _changeService(store, action);
    } else if (action is RestartEvent) {
      await _restart(store, action);
    } else if (action is GetScreenShotOfCurrentServiceEvent) {
      await _getScreenshot(store, action);
    }
  }

  Future _wakeUp(Store<AppState> store, WakeUpEvent action) async {
    try {
      var response = await EnigmaApi.wakeUp(
        requester: requester,
        profile: action.profile,
      );
      store.dispatch(WakeUpSuccessEvent(
        responseDuration: response.responseDuration,
      ));
    } on EnigmaWebException catch (e) {
      store.dispatch(WakeUpErrorEvent(
        error: e,
        profile: action.profile,
      ));
    }
  }

  Future _sleep(Store<AppState> store, SentToSleepEvent action) async {
    try {
      var response = await EnigmaApi.sleep(
        requester: requester,
        profile: action.profile,
      );
      store.dispatch(
          SentToSleepSuccessEvent(responseDuration: response.responseDuration));
    } on EnigmaWebException catch (e) {
      store.dispatch(SentToSleepErrorEvent(
        error: e,
        profile: action.profile,
      ));
    }
  }

  Future _restart(Store<AppState> store, RestartEvent action) async {
    try {
      var response = await EnigmaApi.restart(
        requester: requester,
        profile: action.profile,
      );
      store.dispatch(
          RestartSuccessEvent(responseDuration: response.responseDuration));
    } on EnigmaWebException catch (e) {
      print(e.innerException.message);
      store.dispatch(
        RestartSuccessEvent(
          responseDuration: Duration(
            milliseconds: 0,
          ),
        ),
      );
    }
  }

  Future _getBouquets(Store<AppState> store, GetBouquetsEvent action) async {
    try {
      var response = await EnigmaApi.getBouquets(
        requester: requester,
        profile: action.profile,
      );
      store.dispatch(GetBouquetsSuccessEvent(
        bouquets: response.bouquets,
        responseDuration: response.responseDuration,
      ));
    } on EnigmaWebException catch (e) {
      store.dispatch(GetBouquetsErrorEvent(
        error: e,
        profile: action.profile,
      ));
    }
  }

  Future _getServices(
    Store<AppState> store,
    GetBouquetItemsEvent action,
  ) async {
    if (store.state.bouquetItemsState.cachedBouquetItems
        .containsKey(action.bouquet)) {
      store.dispatch(GetBouquetItemsSuccessEvent(
        bouquet: action.bouquet,
        bouquetItems:
            store.state.bouquetItemsState.cachedBouquetItems[action.bouquet],
        responseDuration: Duration(milliseconds: 0),
      ));
      return;
    }

    try {
      var response = await EnigmaApi.getServices(
        requester: requester,
        bouquet: action.bouquet,
        profile: action.profile,
      );
      store.dispatch(GetBouquetItemsSuccessEvent(
        bouquet: action.bouquet,
        bouquetItems: response.items,
        responseDuration: response.responseDuration,
      ));
    } on EnigmaWebException catch (e) {
      store.dispatch(GetBouquetItemsErrorEvent(
        bouquet: action.bouquet,
        error: e,
        profile: action.profile,
      ));
    }
  }

  Future _getCurrentService(Store<AppState> store) async {
    try {
      var response = await EnigmaApi.getCurrentService(
        requester: requester,
        profile: store.state.profilesState.selectedProfile,
      );
      store.dispatch(
        GetCurrentServiceSuccessEvent(
          responseDuration: response.responseDuration,
          response: response,
        ),
      );
    } on EnigmaWebException catch (e) {
      store.dispatch(
        GetCurrentServiceErrorEvent(
          error: e,
          profile: store.state.profilesState.selectedProfile,
        ),
      );
    }
  }

  Future _changeService(
      Store<AppState> store, ChangeServiceEvent action) async {
    try {
      var response = await EnigmaApi.zapService(
        requester: requester,
        profile: action.profile,
        service: action.service,
      );
      store.dispatch(ChangeServiceSuccessEvent(
        responseDuration: response.responseDuration,
        service: action.service,
      ));
    } on EnigmaWebException catch (e) {
      store.dispatch(ChangeServiceErrorEvent(
        error: e,
        service: action.service,
        profile: action.profile,
      ));
    }
  }

  Future _getScreenshot(
      Store<AppState> store, GetScreenShotOfCurrentServiceEvent action) async {
    try {
      var response = await EnigmaApi.getScreenShotOfCurrentService(
        requester: requester,
        profile: action.profile,
        screenshotType: action.screenshotType,
      );
      store.dispatch(
        GetScreenShotOfCurrentServiceSuccessEvent(
          responseDuration: response.responseDuration,
          response: response,
        ),
      );
    } on EnigmaWebException catch (e) {
      store.dispatch(
        GetScreenShotOfCurrentServiceErrorEvent(
          error: e,
          profile: store.state.profilesState.selectedProfile,
        ),
      );
    }
  }
}
