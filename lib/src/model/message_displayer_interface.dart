import 'package:enigma_signal_meter/src/redux/messages/error_messages_events.dart';
import 'package:enigma_signal_meter/src/redux/messages/info_messages_events.dart';
import 'package:enigma_signal_meter/src/redux/messages/message_event.dart';
import 'package:enigma_signal_meter/src/redux/messages/warning_messages_events.dart';

abstract class MessageDisplayerInterface {
  List<ErrorMessageEvent> get errors;
  List<InfoMessageEvent> get infos;
  List<WarningMessageEvent> get warnings;
  Function(MessageEvent message) get messageShown;
}
