import 'package:flutter/widgets.dart';

class ApplicationSettings {
  bool dbIsPrimaryLevel;

  ApplicationSettings({
    @required this.dbIsPrimaryLevel,
  }) : assert(dbIsPrimaryLevel != null);

  ApplicationSettings copyWith({
    @required bool dbIsPrimaryLevel,
  }) {
    return ApplicationSettings(
      dbIsPrimaryLevel: dbIsPrimaryLevel ?? this.dbIsPrimaryLevel,
    );
  }

  @override
  ApplicationSettings.fromJson(Map<String, dynamic> json)
      : dbIsPrimaryLevel = json['dbIsPrimaryLevel'];

  Map<String, dynamic> toJson() => {
        'dbIsPrimaryLevel': dbIsPrimaryLevel,
      };
}
