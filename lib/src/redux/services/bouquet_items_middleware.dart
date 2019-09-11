import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/redux/bouquets/bouquets_events.dart';
import 'package:enigma_signal_meter/src/redux/enigma/enigma_command_events.dart';
import 'package:enigma_signal_meter/src/utils/string_utils.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:xml/xml.dart' as xml;

import 'bouquet_items_events.dart';

class BouquetItemsMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is GetBouquetItemsErrorEvent) {
      Logger.root.fine(
          "Dispatching BouquetItemsStatusChangedEvent from BouquetItemsMiddleware as response to GetBouquetItemsErrorEvent");
      store.dispatch(BouquetItemsStatusChangedEvent(LoadingStatus.error));
    } else if (action is GetBouquetItemsSuccessEvent) {
      Logger.root.fine(
          "Dispatching BouquetItemsStatusChangedEvent from BouquetItemsMiddleware as response to GetBouquetItemsSuccessEvent");
      store.dispatch(BouquetItemsStatusChangedEvent(LoadingStatus.success));
    } else if (action is GetBouquetItemsEvent) {
      Logger.root.fine(
          "Dispatching BouquetItemsStatusChangedEvent from BouquetItemsMiddleware as response to GetBouquetItemsEvent");
      store.dispatch(BouquetItemsStatusChangedEvent(LoadingStatus.loading));
    } else if (action is BouquetSelectedEvent) {
      Logger.root.fine(
          "Dispatching GetBouquetItemsEvent from BouquetItemsMiddleware as response to BouquetSelectedEvent");
      store.dispatch(GetBouquetItemsEvent(
        profile: store.state.profilesState.selectedProfile,
        bouquet: action.bouquet,
      ));
    } else if (action is SentToSleepSuccessEvent) {
      Logger.root.fine(
          "Dispatching BouquetItemsStatusChangedEvent from BouquetItemsMiddleware as response to SentToSleepSuccessEvent");
      store.dispatch(BouquetItemsStatusChangedEvent(LoadingStatus.idle));
    } else if (action is GetCurrentServiceSuccessEvent) {
      if (action.response.currentService !=
          store.state.bouquetItemsState.selectedService) {
        Logger.root.fine(
            "Dispatching BouquetItemSelectedEvent from BouquetItemsMiddleware as response to GetCurrentServiceSuccessEvent");
        store.dispatch(BouquetItemSelectedEvent(
          bouquetItem: action.response.currentService,
          switchTabs: false,
        ));
      }
    } else if (action is LoadSatellitesEvent) {
      var satellites = await _loadSatellites();
      store.dispatch(SatellitesLoadedEvent(satellites));
    }
    next(action);
  }

  Future<Map<int, String>> _loadSatellites() async {
    var fileContent = await _loadAsset();
    var fileString = StringUtils.sanitizeXmlString(fileContent);
    var satellites = Map<int, String>();
    var document = xml.parse(fileString);
    var children = document.findAllElements("sat");
    if (children != null && children.isNotEmpty) {
      for (final node in children) {
        final nameNode = node.attributes
            .where((attribute) => attribute.name.toString() == 'name')
            .single;
        final positionNode = node.attributes
            .where((attribute) => attribute.name.toString() == 'position')
            .single;

        String satellite = nameNode.value;
        String position = positionNode.value;
        if (satellite != null && satellite.isNotEmpty) {
          satellite = StringUtils.trimAll(satellite);
        }
        if (position != null && position.isNotEmpty) {
          position = StringUtils.trimAll(position);
        }
        if (satellite != null && position != null) {
          satellites.putIfAbsent(int.parse(position), () => satellite);
        }
      }
      return satellites;
    }
    return Map<int, String>();
  }

  Future<String> _loadAsset() async {
    return await rootBundle.loadString('assets/satellites.xml');
  }
}
