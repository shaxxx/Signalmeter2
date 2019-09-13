import 'package:enigma_signal_meter/src/i18n/messages.dart';
import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:enigma_signal_meter/src/redux/app/app_state.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class SignalCircularProgressViewModel {
  final bool hasdb;
  final String stringValue;
  final double doubleValue;
  final String footerValue;
  final bool isBerView;
  final bool hasInfo;

  static bool _hasInfo(ISignalResponse signalResponse) {
    if (signalResponse == null ||
        signalResponse.signal == null ||
        signalResponse.signal.snr == null) {
      return false;
    }
    return signalResponse.signal.snr >= 0;
  }

  SignalCircularProgressViewModel({
    @required this.stringValue,
    @required this.doubleValue,
    @required this.footerValue,
    @required this.hasdb,
    @required this.hasInfo,
    @required this.isBerView,
  })  : assert(stringValue != null),
        assert(doubleValue != null && doubleValue >= 0 && doubleValue <= 1),
        assert(footerValue != null),
        assert(hasdb != null),
        assert(hasInfo != null),
        assert(isBerView != null);

  static String _snrString(
    ISignalResponse signalResponse,
    Messages messages,
  ) {
    if (signalResponse == null) {
      return messages.noInformation;
    }
    if (signalResponse.signal.snr == -1) {
      return messages.noInformation;
    }
    return '${signalResponse.signal.snr}';
  }

  static double _snrDouble(ISignalResponse signalResponse) {
    if (signalResponse == null) {
      return 0;
    }
    if (signalResponse.signal.snr == -1) {
      return 0;
    }
    return (signalResponse.signal.snr / 100);
  }

  static String _dbString(
    ISignalResponse signalResponse,
    Messages messages,
  ) {
    if (signalResponse == null) {
      return messages.noInformation;
    }
    if (signalResponse.signal is E2Signal) {
      var db = (signalResponse.signal as E2Signal).db;
      if (db == -1) {
        return messages.noInformation;
      }
      return '${db.round()}';
    }
    return messages.noInformation;
  }

  static double _dbDouble(ISignalResponse signalResponse) {
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

  static String _acgString(
    ISignalResponse signalResponse,
    Messages messages,
  ) {
    if (signalResponse == null) {
      return messages.noInformation;
    }
    if (signalResponse.signal.acg == -1) {
      return messages.noInformation;
    }
    return '${signalResponse.signal.acg}';
  }

  static double _acgDouble(ISignalResponse signalResponse) {
    if (signalResponse == null) {
      return 0;
    }
    if (signalResponse.signal.acg == -1) {
      return 0;
    }
    return (signalResponse.signal.acg / 100);
  }

  static String _berString(
    ISignalResponse signalResponse,
    Messages messages,
  ) {
    if (signalResponse == null) {
      return messages.noInformation;
    }
    if (signalResponse.signal.ber == -1) {
      return messages.noInformation;
    }
    return '${signalResponse.signal.ber}';
  }

  static double _berDouble(
    ISignalResponse signalResponse,
  ) {
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

  static String _getStringValue(
    ISignalResponse signalResponse,
    SignalViewEnum signalView,
    Messages messages,
  ) {
    switch (signalView) {
      case SignalViewEnum.CircularSnr:
        return _snrString(signalResponse, messages);
        break;
      case SignalViewEnum.CircularDb:
        return _dbString(signalResponse, messages);
        break;
      case SignalViewEnum.CircularAcg:
        return _acgString(signalResponse, messages);
        break;
      case SignalViewEnum.CircularBer:
        return _berString(signalResponse, messages);
        break;
      default:
        return _snrString(signalResponse, messages);
    }
  }

  static String _getFooterValue(
    SignalViewEnum signalView,
  ) {
    switch (signalView) {
      case SignalViewEnum.CircularSnr:
        return 'SNR';
        break;
      case SignalViewEnum.CircularDb:
        return 'dB';
        break;
      case SignalViewEnum.CircularAcg:
        return 'ACG';
        break;
      case SignalViewEnum.CircularBer:
        return 'BER';
        break;
      default:
        return 'SNR';
    }
  }

  static double _getDoubleValue(
      SignalViewEnum signalView, ISignalResponse signalResponse) {
    switch (signalView) {
      case SignalViewEnum.CircularSnr:
        return _snrDouble(signalResponse);
        break;
      case SignalViewEnum.CircularDb:
        return _dbDouble(signalResponse);
        break;
      case SignalViewEnum.CircularAcg:
        return _acgDouble(signalResponse);
        break;
      case SignalViewEnum.CircularBer:
        return _berDouble(signalResponse);
        break;
      default:
        return _snrDouble(signalResponse);
    }
  }

  static SignalCircularProgressViewModel fromStore(
      Store<AppState> store, Messages messages) {
    var signalResponse = store.state.signalMonitorState.responses.isNotEmpty
        ? store.state.signalMonitorState.responses.last
        : null;
    var signalView = store.state.tabsState.signalView;
    return SignalCircularProgressViewModel(
      stringValue: _getStringValue(signalResponse, signalView, messages),
      footerValue: _getFooterValue(signalView),
      doubleValue: _getDoubleValue(signalView, signalResponse),
      hasdb: signalResponse is E2Signal,
      hasInfo: _hasInfo(signalResponse),
      isBerView: signalView == SignalViewEnum.CircularBer,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignalCircularProgressViewModel &&
          runtimeType == other.runtimeType &&
          hasdb == other.hasdb &&
          stringValue == other.stringValue &&
          doubleValue == other.doubleValue &&
          footerValue == other.footerValue &&
          hasInfo == other.hasInfo &&
          isBerView == other.isBerView;

  @override
  int get hashCode =>
      hasdb.hashCode ^
      stringValue.hashCode ^
      doubleValue.hashCode ^
      footerValue.hashCode ^
      hasInfo.hashCode ^
      isBerView.hashCode;
}
