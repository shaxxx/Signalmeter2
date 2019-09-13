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
    return signal.snr / 10;
  }

  SignalChartViewModel({
    @required this.responses,
    @required this.messages,
  }) : assert(responses != null);

  static SignalChartViewModel fromStore(
      Store<AppState> store, Messages messages) {
    return SignalChartViewModel(
      responses: store.state.signalMonitorState.responses,
      messages: messages,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignalChartViewModel &&
          runtimeType == other.runtimeType &&
          messages == other.messages &&
          const IterableEquality().equals(responses, other.responses);

  @override
  int get hashCode =>
      const IterableEquality().hash(responses) ^ messages.hashCode;
}
