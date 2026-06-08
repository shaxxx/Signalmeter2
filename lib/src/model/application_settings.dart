import 'package:enigma_signal_meter/src/model/enums.dart';

class ApplicationSettings {
  bool dbIsPrimaryLevel;
  ChannelUpDownButtonsEnum channelUpDownButtons;

  ApplicationSettings({
    required this.dbIsPrimaryLevel,
    required this.channelUpDownButtons,
  });

  ApplicationSettings copyWith({
    bool? dbIsPrimaryLevel,
    ChannelUpDownButtonsEnum? channelUpDownButtons,
  }) {
    return ApplicationSettings(
      dbIsPrimaryLevel: dbIsPrimaryLevel ?? this.dbIsPrimaryLevel,
      channelUpDownButtons: channelUpDownButtons ?? this.channelUpDownButtons,
    );
  }

  ApplicationSettings.fromJson(Map<String, dynamic> json)
      : dbIsPrimaryLevel = json['dbIsPrimaryLevel'] as bool? ?? false,
        channelUpDownButtons = ChannelUpDownButtonsEnum
            .values[(json['channelUpDownButtons'] as int? ?? 0)];

  Map<String, dynamic> toJson() => {
        'dbIsPrimaryLevel': dbIsPrimaryLevel,
        'channelUpDownButtons': channelUpDownButtons.index,
      };
}
