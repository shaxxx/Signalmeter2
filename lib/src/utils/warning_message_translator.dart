import 'package:enigma_signal_meter/src/i18n/messages.dart';
import 'package:enigma_signal_meter/src/redux/messages/warning_messages_events.dart';
import 'package:enigma_signal_meter/src/utils/error_message_translator.dart';

class WarningMessageTranslator {
  static String translate(
    Messages messages,
    WarningMessageEvent event,
  ) {
    if (event is UnsupportedPlatformMessageEvent) {
      return messages.platformNotSupported(event.platform);
    } else if (event is FailedStreamPortMessageEvent) {
      return messages.errFailedToInitializeStream +
          '\n' +
          messages.warnStreamingPortClosed;
    } else if (event is TtsInitFailedMessageEvent) {
      return messages.errFailedToInitializeTtsEngine +
          ' ' +
          messages.errNoTtsLanguageAvailable;
    } else if (event is TtsSpeakFailedMessageEvent) {
      return messages.errFailedToInitializeTtsEngine +
          ' ' +
          _safeErrorMessage(event.error);
    } else if (event is VlcRequiredMessageEvent) {
      return messages.streamRequiresVlc;
    } else if (event is FormInvalidMessageEvent) {
      return messages.formNotValid;
    }
    return event.toString();
  }

  static String _safeErrorMessage(dynamic error) {
    if (error == null) {
      return '';
    }
    try {
      return error.message;
    } catch (e) {
      return ErrorMessageTranslator.prettyInstanceTypeString(error);
    }
  }
}
