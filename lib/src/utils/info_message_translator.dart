import 'package:enigma_signal_meter/src/i18n/messages.dart';
import 'package:enigma_signal_meter/src/redux/messages/info_messages_events.dart';

class InfoMessageTranslator {
  static String translate(
    Messages messages,
    InfoMessageEvent event,
  ) {
    if (event is InitializingStreamMessageEvent) {
      return messages.infInitializingStream;
    } else if (event is CheckingPortsInfoMessageEvent) {
      return messages.checkingPorts;
    } else if (event is ScreenshotSavedInfoMessageEvent) {
      return messages.screenshotSaved;
    }
    return event.toString();
  }
}
