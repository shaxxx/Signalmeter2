import 'package:enigma_signal_meter/src/model/enums.dart';
import 'package:flutter/widgets.dart';

class ApplicationSettings {
  bool dbIsPrimaryLevel;
  ChannelUpDownButtonsEnum channelUpDownButtons;

  ApplicationSettings({
    @required this.dbIsPrimaryLevel,
    @required this.channelUpDownButtons,
  }) : assert(dbIsPrimaryLevel != null);

  ApplicationSettings copyWith({
    bool dbIsPrimaryLevel,
    ChannelUpDownButtonsEnum channelUpDownButtons,
  }) {
    return ApplicationSettings(
      dbIsPrimaryLevel: dbIsPrimaryLevel ?? this.dbIsPrimaryLevel,
      channelUpDownButtons: channelUpDownButtons ?? this.channelUpDownButtons,
    );
  }

  @override
  ApplicationSettings.fromJson(Map<String, dynamic> json) {
    dbIsPrimaryLevel = json['dbIsPrimaryLevel'];
    int channelUpDownButtonsIndex = json['channelUpDownButtons'];
    channelUpDownButtons =
        ChannelUpDownButtonsEnum.values[channelUpDownButtonsIndex ?? 0];
  }

  Map<String, dynamic> toJson() => {
        'dbIsPrimaryLevel': dbIsPrimaryLevel,
        'channelUpDownButtons': channelUpDownButtons.index,
      };
}
