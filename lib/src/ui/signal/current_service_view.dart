import 'package:enigma_signal_meter/src/i18n/messages.dart';
import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_signal_meter/src/ui/common/title_panel_view.dart';
import 'package:enigma_signal_meter/src/utils/enigma_utils.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../message_provider.dart';
import 'current_service_viewmodel.dart';

class CurrentServiceView extends StatelessWidget {
  String getServiceType(IBouquetItemService service, Messages messages) {
    var serviceType = EnigmaUtils.serviceInfo(service);
    if (serviceType == ServiceType.DVBS) {
      return messages.dvbsService;
    } else if (serviceType == ServiceType.DVBT) {
      return messages.dvbtService;
    } else if (serviceType == ServiceType.DVBC) {
      return messages.dvbcService;
    } else if (serviceType == ServiceType.Stream) {
      return messages.streamService;
    } else {
      return '';
    }
  }

  String _serviceInfo(CurrentServiceViewModel viewModel, Messages messages) {
    var serviceType = EnigmaUtils.serviceInfo(viewModel.currentService);
    if (serviceType == ServiceType.DVBS) {
      var satellite =
          _findSatellite(viewModel.satellites, viewModel.currentService);
      if (satellite != null) {
        return satellite.value;
      }
    }
    return getServiceType(viewModel.currentService, messages);
  }

  static MapEntry<int, String> _findSatellite(
      Map<int, String> satellites, IBouquetItemService service) {
    var position = EnigmaUtils.getSatellitePosition(service);
    if (position == 0) {
      return null;
    }
    if (satellites.containsKey(position)) {
      return satellites.entries.where((entry) => entry.key == position).single;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CurrentServiceViewModel>(
      distinct: true,
      converter: (store) =>
          CurrentServiceViewModel.fromStore(store, MessageProvider.of(context)),
      builder: (context, viewModel) {
        return TitlePanelView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                child: Text(
                  '${viewModel.currentService == null ? '' : viewModel.currentService.name}',
                  style: const TextStyle(fontSize: 20.0, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(bottom: 10),
                alignment: Alignment.center,
                child: Text(
                  '${_serviceInfo(viewModel, MessageProvider.of(context))}',
                  style: const TextStyle(fontSize: 15.0, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
