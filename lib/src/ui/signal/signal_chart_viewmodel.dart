import 'package:enigma_signal_meter/src/i18n/messages.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:collection/collection.dart';

import '../../constants.dart';

class SignalChartViewModel {
  final List<ISignalResponse> responses;
  final Messages messages;
  final bool dbIsPrimaryLevel;
  final IProfile profile;

  bool get useDb => profile.enigma == EnigmaType.enigma2 && dbIsPrimaryLevel;

  Map<double, double> get chartPoints {
    var list = Map<double, double>();

    for (var i = 0; i < signalChartPoints - responses.length; i++) {
      list.putIfAbsent(i.toDouble(), () => 0);
    }
    var existing = list.length;
    for (var i = 0; i < responses.length; i++) {
      list.putIfAbsent(i.toDouble() + existing, () => _convertedSignal(i));
    }
    return list;
  }

  String requestTimeString() {
    if (responses == null) {
      return '';
    }
    if (responses.isEmpty) {
      return '';
    }
    var signalResponse = responses.last;
    return '${messages.requestTime}: ${signalResponse.responseDuration.inMilliseconds} ms';
  }

  String averageTimeString() {
    if (responses == null) {
      return '';
    }
    if (responses.isEmpty) {
      return '';
    }
    int averageResponseTime = responses
            .map((response) => response.responseDuration.inMilliseconds)
            .reduce((a, b) => a + b) ~/
        responses.length;
    return '${messages.average}: $averageResponseTime ms';
  }

  double _convertedSignal(int index) {
    var signal = responses[index].signal;
    if (signal == null) {
      return 0.0;
    }
    if (signal.snr < 0) {
      return 0.0;
    }

    if (useDb) {
      var db = (signal as IE2Signal).db;
      if (db > 16.00) {
        return 16.00;
      }
      return db;
    }
    return signal.snr.toDouble();
  }

  SignalChartViewModel({
    @required this.responses,
    @required this.messages,
    @required this.dbIsPrimaryLevel,
    @required this.profile,
  })  : assert(responses != null),
        assert(dbIsPrimaryLevel != null),
        assert(profile != null);

  static SignalChartViewModel fromStore(
      Store<AppState> store, Messages messages) {
    return SignalChartViewModel(
      responses: store.state.signalMonitorState.responses,
      messages: messages,
      dbIsPrimaryLevel:
          store.state.globalState.applicationSettings.dbIsPrimaryLevel,
      profile: store.state.profilesState.selectedProfile,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignalChartViewModel &&
          runtimeType == other.runtimeType &&
          messages == other.messages &&
          profile == other.profile &&
          dbIsPrimaryLevel == other.dbIsPrimaryLevel &&
          const IterableEquality().equals(responses, other.responses);

  @override
  int get hashCode =>
      const IterableEquality().hash(responses) ^
      messages.hashCode ^
      profile.hashCode ^
      dbIsPrimaryLevel.hashCode;
}
