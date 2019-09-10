import 'package:enigma_signal_meter/src/i18n/messages.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class SignalProgressbarViewModel {
  final ISignalResponse signalResponse;
  final Messages messages;
  bool get hasdb => signalResponse?.signal is E2Signal;

  SignalProgressbarViewModel(
      {@required this.signalResponse, @required this.messages});

  String snrString() {
    if (signalResponse == null) {
      return messages.noInformation;
    }
    if (signalResponse.signal.snr == -1) {
      return messages.noInformation;
    }
    return '${signalResponse.signal.snr}%';
  }

  double snrDouble() {
    if (signalResponse == null) {
      return 0;
    }
    if (signalResponse.signal.snr == -1) {
      return 0;
    }
    return (signalResponse.signal.snr / 100);
  }

  String dbString() {
    if (signalResponse == null) {
      return messages.noInformation;
    }
    if (signalResponse.signal is E2Signal) {
      var db = (signalResponse.signal as E2Signal).db;
      if (db == -1) {
        return messages.noInformation;
      }
      return 'dB: ${db.round()}';
    }
    return messages.noInformation;
  }

  double dbDouble() {
    if (signalResponse == null) {
      return 0;
    }
    if (signalResponse.signal is E2Signal) {
      var db = (signalResponse.signal as E2Signal).db;
      if (db < 0) {
        return 0;
      }
      var dbPercent = db * 6.67 / 100;
      if (dbPercent > 1.0) {
        dbPercent = 1.0;
      }
      return dbPercent;
    }
    return 0;
  }

  String acgString() {
    if (signalResponse == null) {
      return messages.noInformation;
    }
    if (signalResponse.signal.acg == -1) {
      return messages.noInformation;
    }
    return 'ACG: ${signalResponse.signal.acg}%';
  }

  double acgDouble() {
    if (signalResponse == null) {
      return 0;
    }
    if (signalResponse.signal.acg == -1) {
      return 0;
    }
    return (signalResponse.signal.acg / 100);
  }

  String berString() {
    if (signalResponse == null) {
      return messages.noInformation;
    }
    if (signalResponse.signal.ber == -1) {
      return messages.noInformation;
    }
    return 'BER: ${signalResponse.signal.ber}';
  }

  double berDouble() {
    if (signalResponse == null) {
      return 0;
    }
    if (signalResponse.signal.ber == -1) {
      return 0;
    }
    var ber = signalResponse.signal.ber;
    if (ber < 0) {
      return 0;
    }
    var berPercent = ber / 200000;
    if (berPercent > 1.0) {
      berPercent = 1.0;
    }
    return berPercent;
  }

  static SignalProgressbarViewModel fromStore(
      Store<AppState> store, Messages messages) {
    return SignalProgressbarViewModel(
      signalResponse: store.state.signalMonitorState.responses.length > 0
          ? store.state.signalMonitorState.responses.last
          : null,
      messages: messages,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignalProgressbarViewModel &&
          runtimeType == other.runtimeType &&
          signalResponse == other.signalResponse &&
          messages == other.messages;

  @override
  int get hashCode =>
      signalResponse == null ? 0 : signalResponse.hashCode ^ messages.hashCode;
}
