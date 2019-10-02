import 'dart:convert';

import 'package:enigma_signal_meter/src/model/application_settings.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static const String _profiles_key = "com.krkadoni.app.signalmeter.Profiles";
  static const String _appSettings_key =
      "com.krkadoni.app.signalmeter.ApplicationSettings";

  static Future<bool> saveProfiles(List<IProfile> profiles) async {
    var json = jsonEncode(profiles);
    var prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_profiles_key, json);
  }

  static Future<List<Profile>> loadProfiles() async {
    List<Profile> profiles = List<Profile>();
    var prefs = await SharedPreferences.getInstance();
    var json = prefs.getString(_profiles_key);
    if (json != null) {
      List<dynamic> profilesMap = jsonDecode(json);
      for (var item in profilesMap) {
        profiles.add(Profile.fromJson(item));
      }
    }
    return profiles;
  }

  static Future<bool> saveApplicationSettings(
      ApplicationSettings settings) async {
    var json = jsonEncode(settings);
    var prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_appSettings_key, json);
  }

  static Future<ApplicationSettings> loadApplicationSettings() async {
    var prefs = await SharedPreferences.getInstance();
    var json = prefs.getString(_appSettings_key);
    if (json != null) {
      Map<String, dynamic> settings = jsonDecode(json);
      return ApplicationSettings.fromJson(settings);
    }
    return ApplicationSettings(dbIsPrimaryLevel: false);
  }
}
