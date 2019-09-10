import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsUtils {
  final FlutterTts _flutterTts;
  static TtsUtils _instance;
  static String get language => _language;
  static String _language;

  factory TtsUtils() {
    if (_instance == null) {
      _instance = TtsUtils._internal(FlutterTts());
    }
    return _instance;
  }

  TtsUtils._internal(this._flutterTts);

  static Future setLanguage(Locale locale) async {}

  static Future configure() async {
    var instance = TtsUtils();
    await instance._flutterTts.setSpeechRate(Platform.isIOS ? 0.5 : 1.0);
    await instance._flutterTts.setVolume(1.0);
    await instance._flutterTts.setPitch(1.0);
  }

  static Future speak(String text) async {
    var instance = TtsUtils();
    await instance._flutterTts.speak(text);
  }

  static void setSpeakEndHandler(Function callback) {
    var instance = TtsUtils();
    instance._flutterTts.setCompletionHandler(callback);
  }

  static void setSpeakErrorHandler(Function(dynamic) callback) {
    var instance = TtsUtils();
    instance._flutterTts.setErrorHandler(callback);
  }
}
