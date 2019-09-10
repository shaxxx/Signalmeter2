import 'dart:io';

import 'package:enigma_signal_meter/src/i18n/messages.dart';
import 'package:enigma_signal_meter/src/redux/messages/error_messages_events.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:flutter/widgets.dart';

class TranslatedErrorMessage {
  final String message;
  final String details;
  TranslatedErrorMessage({
    @required this.message,
    this.details,
  }) : assert(message != null);
}

class ErrorMessageTranslator {
  static TranslatedErrorMessage translate(
    Messages messages,
    ErrorMessageEvent event,
  ) {
    if (event is FailedStreamExtraParametersMessageEvent) {
      return _translateFailedStreamExtraParametersMessage(event, messages);
    } else if (event is EnigmaCommandErrorMessageEvent) {
      return _translateEnigmaCommandErrorMessage(event, messages);
    }
    return TranslatedErrorMessage(
        message: messages.unknownError + '\n' + messages.pleaseSubmitDetails,
        details: _getDynamicErrorMessage(event.exception));
  }

  static String prettyInstanceTypeString(dynamic instance) {
    return instance
        .toString()
        .replaceAll('Instance of ' '', '')
        .replaceAll('Command', '')
        .replaceAll("'", '');
  }

  static String _commandFailedMessage(Messages messages, ICommand command) {
    return messages.errCommandFailed(
      prettyInstanceTypeString(command),
    );
  }

  static String _getDynamicErrorMessage(dynamic error) {
    if (error == null) {
      return null;
    }
    try {
      if (error.error != null) {
        String message;
        try {
          message = error.error.message;
        } catch (e) {
          return prettyInstanceTypeString(error.error);
        }

        if (message == null || message.length == 0) {
          try {
            message = error.error.osError.message;
          } catch (e) {
            return prettyInstanceTypeString(error.error);
          }
        }

        if (message != null && message.length > 0) {
          return message;
        }
      }
      if (error.message != null && error.message.length > 0) {
        return error.message;
      } else {
        return prettyInstanceTypeString(error);
      }
    } catch (e) {
      return prettyInstanceTypeString(error);
    }
  }

  static String _getErrorDetails(EnigmaCommandErrorMessageEvent event) {
    return _getDynamicErrorMessage(
      event.exception.innerException.innerException,
    );
  }

  static String _getErrorDetailsOrEnigmaExceptionMessage(
    EnigmaCommandErrorMessageEvent event,
  ) {
    if (event.exception.innerException.innerException != null) {
      return _getDynamicErrorMessage(
        event.exception.innerException.innerException,
      );
    }
    return event.exception.innerException.message;
  }

  static TranslatedErrorMessage _translateFailedStreamExtraParametersMessage(
    FailedStreamExtraParametersMessageEvent event,
    Messages messages,
  ) {
    var message = messages.errFailedToInitializeStream +
        '\n' +
        _commandFailedMessage(
          messages,
          event.exception.command,
        );
    var details = _getDynamicErrorMessage(
      event.exception.innerException,
    );
    return TranslatedErrorMessage(
      message: message,
      details: details,
    );
  }

  static TranslatedErrorMessage _translateEnigmaCommandErrorMessage(
    EnigmaCommandErrorMessageEvent event,
    Messages messages,
  ) {
    if (event.exception.command is WakeUpCommand &&
        event.exception.innerException is WebRequestException) {
      return _translateWakeUpFailedConnect(event, messages);
    } else if (event.exception.command is WakeUpCommand &&
        event.exception.innerException is FailedStatusCodeException) {
      return _translateWakeUpFailedStatusCode(event, messages);
    } else if (event.exception.innerException is TimeOutException) {
      return _translateTimeOutException(event, messages);
    } else if (event.exception.innerException is WebRequestException) {
      return _translateWebRequestException(event, messages);
    } else if (event.exception.innerException is CommandException) {
      return _translateWebRequestException(event, messages);
    } else if (event.exception.innerException is ParsingException) {
      return _translateParsingException(event, messages);
    } else if (event.exception.innerException is FailedStatusCodeException) {
      return _translateFailedStatusCodeException(event, messages);
    }
    return _safeEnigmaErrorInfo(event);
  }

  static TranslatedErrorMessage _safeEnigmaErrorInfo(
      EnigmaCommandErrorMessageEvent event) {
    var message = event.exception.innerException.message;
    if (message == null) {
      message = prettyInstanceTypeString(event.exception.innerException);
    }
    return TranslatedErrorMessage(
      message: message,
      details: _getErrorDetails(event),
    );
  }

  static TranslatedErrorMessage _translateWakeUpFailedConnect(
    EnigmaCommandErrorMessageEvent event,
    Messages messages,
  ) {
    var message = messages.errFailedConnect(event.action.profile.name) +
        '\n' +
        messages.errCheckYourSettings;
    return TranslatedErrorMessage(
      message: message,
      details: _getErrorDetails(event),
    );
  }

  static TranslatedErrorMessage _translateWakeUpFailedStatusCode(
    EnigmaCommandErrorMessageEvent event,
    Messages messages,
  ) {
    String message;
    String details = _getErrorDetailsOrEnigmaExceptionMessage(event);

    var failedEx = event.exception.innerException as FailedStatusCodeException;
    if (failedEx.statusCode == HttpStatus.notFound) {
      message = messages.errFailedConnect(event.action.profile.name) +
          '\n' +
          messages.errInvalidEnigmaTypeOrNotEnigma;
    } else if (failedEx.statusCode == HttpStatus.internalServerError) {
      message = _commandFailedMessage(messages, event.exception.command) +
          '\n' +
          messages.errServerError(event.action.profile.address);
    } else if (failedEx.statusCode == HttpStatus.unauthorized ||
        failedEx.statusCode == HttpStatus.forbidden) {
      message = _commandFailedMessage(messages, event.exception.command) +
          '\n' +
          messages.errCheckYourCredentials;
    } else {
      message = _commandFailedMessage(messages, event.exception.command) +
          '\n' +
          messages.errRequestFailedWithStatusCode(failedEx.statusCode);
    }

    return TranslatedErrorMessage(
      message: message,
      details: details,
    );
  }

  static TranslatedErrorMessage _translateTimeOutException(
    EnigmaCommandErrorMessageEvent event,
    Messages messages,
  ) {
    var message = _commandFailedMessage(messages, event.exception.command) +
        '\n' +
        messages.errOperationTimedOut;
    return TranslatedErrorMessage(
      message: message,
      details: _getErrorDetails(event),
    );
  }

  static TranslatedErrorMessage _translateWebRequestException(
    EnigmaCommandErrorMessageEvent event,
    Messages messages,
  ) {
    String message;
    String details = _getErrorDetails(event);
    if (event.exception.innerException.message.contains('SocketException')) {
      message = _commandFailedMessage(messages, event.exception.command) +
          '\n' +
          messages.errCheckYourConnection;
    } else {
      message = _commandFailedMessage(messages, event.exception.command);
    }
    return TranslatedErrorMessage(
      message: message,
      details: details,
    );
  }

  static TranslatedErrorMessage _translateParsingException(
    EnigmaCommandErrorMessageEvent event,
    Messages messages,
  ) {
    var message = _commandFailedMessage(messages, event.exception.command) +
        '\n' +
        messages.failedToParseResponse;
    return TranslatedErrorMessage(
      message: message,
      details: _getErrorDetailsOrEnigmaExceptionMessage(event),
    );
  }

  static TranslatedErrorMessage _translateFailedStatusCodeException(
    EnigmaCommandErrorMessageEvent event,
    Messages messages,
  ) {
    String message;
    var failedEx = event.exception.innerException as FailedStatusCodeException;
    if (failedEx.statusCode == HttpStatus.internalServerError) {
      message = _commandFailedMessage(messages, event.exception.command) +
          '\n' +
          messages.errServerError(event.action.profile.address);
    } else {
      message = _commandFailedMessage(messages, event.exception.command) +
          '\n' +
          messages.errRequestFailedWithStatusCode(failedEx.statusCode);
    }
    return TranslatedErrorMessage(
      message: message,
      details: _getErrorDetailsOrEnigmaExceptionMessage(event),
    );
  }
}
