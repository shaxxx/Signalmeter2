import 'package:enigma_signal_meter/src/model/message_displayer_interface.dart';
import 'package:enigma_signal_meter/src/utils/info_message_translator.dart';
import 'package:enigma_signal_meter/src/utils/snackbar_handler.dart';
import 'package:enigma_signal_meter/src/utils/warning_message_translator.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../message_provider.dart';

import 'error_message_translator.dart';

class MessageDisplayHandler {
  static Future displayMessages({
    BuildContext context,
    MessageDisplayerInterface viewModel,
  }) async {
    await _displayInfoMessages(viewModel, context);
    await _displayWarningMessages(viewModel, context);
    await _displayErrorMessages(viewModel, context);
  }

  static Future _displayErrorMessages(
      MessageDisplayerInterface viewModel, BuildContext context) async {
    if (viewModel.errors.isNotEmpty) {
      var messageEvent = viewModel.errors.first;
      viewModel.errors.remove(messageEvent);
      viewModel.messageShown(messageEvent);
      var translation = ErrorMessageTranslator.translate(
        MessageProvider.of(context),
        messageEvent,
      );
      Logger.root.severe(translation.message);
      if (translation.details != null) {
        Logger.root.severe(translation.details);
      }
      await SnackbarHandler.showErrorSnackBar(
        context,
        translation.message,
        translation.details,
      );
    }
  }

  static Future _displayInfoMessages(
      MessageDisplayerInterface viewModel, BuildContext context) async {
    if (viewModel.infos.isNotEmpty) {
      var messageEvent = viewModel.infos.first;
      viewModel.infos.remove(messageEvent);
      viewModel.messageShown(messageEvent);
      var message = InfoMessageTranslator.translate(
        MessageProvider.of(context),
        messageEvent,
      );
      await SnackbarHandler.showInfoSnackBar(
        context,
        message,
      );
    }
  }

  static Future _displayWarningMessages(
      MessageDisplayerInterface viewModel, BuildContext context) async {
    if (viewModel.warnings.isNotEmpty) {
      var messageEvent = viewModel.warnings.first;
      viewModel.warnings.remove(messageEvent);
      viewModel.messageShown(messageEvent);
      var message = WarningMessageTranslator.translate(
        MessageProvider.of(context),
        messageEvent,
      );
      await SnackbarHandler.showWarningSnackBar(
        context,
        message,
      );
    }
  }
}
