import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/utils/preference_manager.dart';
import 'package:enigma_signal_meter/src/utils/string_utils.dart';
import 'package:redux/redux.dart';
import 'package:xml/xml.dart' as xml;
import 'global_events.dart';
import 'package:flutter/services.dart' show rootBundle;

class GlobalMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoadSatellitesEvent) {
      var satellites = await _loadSatellites();
      store.dispatch(SatellitesLoadedEvent(satellites));
    } else if (action is LoadApplicationSettingsEvent) {
      var settings = await PreferenceManager.loadApplicationSettings();
      store.dispatch(ApplicationSettingsChangedEvent(settings));
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
