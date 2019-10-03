import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

List<String> languages = ['en', 'hr', 'bs', 'sr', 'sl'];
const double listItemHeight = 50;
const Duration currentServiceMonitorDelay = Duration(seconds: 15);
const int signalChartPoints = 30;
const String backgroundAsset = 'assets/sky.jpg';
const String satelliteAsset = 'assets/satellite.jpg';
const String cupAsset = 'assets/cup.png';
const int visibleMenuItemsCount = 2;
const String appBarTitle = "SignalMeter";
const int ttsSpeakDelayInMiliseconds = 1500;
const Duration infoMessageDuration = Duration(seconds: 2);
const Duration warningMessageDuration = Duration(seconds: 3);
const Duration errorMessageDuration = Duration(seconds: 5);
const String disableTtsMenuItemKey = 'disableTtsMenuItem';
const String enableTtsMenuItemKey = 'enableTtsMenuItem';
const String defaultLookMenuItemKey = 'defaultLookMenuItem';
const String alternativeLookMenuItemKey = 'alternativeLookMenuItem';
const String streamMenuItemKey = 'streamMenuItem';
const String screenshotMenuItemKey = 'screenshotMenuItem';
const String sendToSleepMenuItemKey = 'sendToSleepMenuItemKey';
const String restartMenuItemKey = 'restartMenuItemKey';
const String aboutMenuItemKey = 'aboutMenuItemKey';
const String saveMenuItemKey = 'saveMenuItemKey';
const String shareMenuItemKey = 'shareMenuItemKey';
const int signalMonitorRetries = 2;
const int signalMonitorReceiveTimeout = 1000;
const String satelitskiForumUrl = 'https://satelitskiforum.com';
const String krkadoniUrl = 'https://www.krkadoni.com';
const String buyCoffeeUrl = 'https://www.buymeacoffee.com/SuPbZXxNo';
const Map<String, IconData> menuIcons = {
  disableTtsMenuItemKey: Icons.volume_off,
  enableTtsMenuItemKey: Icons.record_voice_over,
  defaultLookMenuItemKey: Icons.insert_chart,
  alternativeLookMenuItemKey: Icons.av_timer,
  streamMenuItemKey: Icons.cast_connected,
  screenshotMenuItemKey: Icons.satellite,
  sendToSleepMenuItemKey: Icons.power_settings_new,
  restartMenuItemKey: Icons.loop,
  aboutMenuItemKey: Icons.info,
  saveMenuItemKey: Icons.save,
  shareMenuItemKey: Icons.share,
};
