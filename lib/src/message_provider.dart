import 'dart:async';
import 'dart:ui';

import 'package:enigma_signal_meter/src/i18n/messages.dart';
import 'package:enigma_signal_meter/src/i18n/messages_all.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'constants.dart';

class MessageProvider {
  MessageProvider(this.messages);
  final Messages messages;

  static Future<MessageProvider> load(Locale locale) {
    final name = locale.languageCode;
    final localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return MessageProvider(Messages());
    });
  }

  static Messages of(BuildContext context) {
    return Localizations.of<MessageProvider>(context, MessageProvider).messages;
  }
}

class SignalMeterLocalizationsDelegate
    extends LocalizationsDelegate<MessageProvider> {
  const SignalMeterLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => languages.contains(locale.languageCode);

  static Locale getTranslatedLocale(Locale locale) {
    var hrLanguage = ['hr', 'bs', 'sr', 'sl'];
    if (locale.languageCode == 'en') {
      return locale;
    } else if (languages.contains(locale.languageCode)) {
      if (hrLanguage.contains(locale.languageCode)) {
        return Locale.fromSubtags(languageCode: 'hr');
      }
      return locale;
    }
    return Locale.fromSubtags(languageCode: 'en');
  }

  static String getWebLanguageCode(Locale locale) {
    var translatedLocale = getTranslatedLocale(locale);
    if (translatedLocale.languageCode == 'nl') return 'en';
    return translatedLocale.languageCode;
  }

  @override
  Future<MessageProvider> load(Locale locale) {
    var translatedLocale = getTranslatedLocale(locale);
    return MessageProvider.load(translatedLocale);
  }

  @override
  bool shouldReload(SignalMeterLocalizationsDelegate old) => false;
}
