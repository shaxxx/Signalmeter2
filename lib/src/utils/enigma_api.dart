import 'package:enigma_signal_meter/src/model/enigma_web_exception.dart';
import 'package:enigma_web/enigma_web.dart';

class EnigmaApi {
  static Future<IGetStreamParametersResponse> getStreamParameters({
    required IWebRequester requester,
    required IProfile profile,
    required IBouquetItemService service,
  }) async {
    var parser = GetStreamParametersParser();
    var command = GetStreamParametersCommand(
      parser,
      requester,
      profile,
      service,
    );
    try {
      return await command.executeAsync();
    } on KnownException catch (e) {
      throw EnigmaWebException(
        command: command,
        innerException: e,
      );
    }
  }

  static Future<IResponse<IWakeUpCommand>> wakeUp({
    required IWebRequester requester,
    required IProfile profile,
  }) async {
    var parser = UnparsedParser<WakeUpCommand>();
    var command = WakeUpCommand(
      parser,
      requester,
      profile,
    );
    try {
      return await command.executeAsync();
    } on KnownException catch (e) {
      throw EnigmaWebException(
        command: command,
        innerException: e,
      );
    }
  }

  static Future<IResponse<ISleepCommand>> sleep({
    required IWebRequester requester,
    required IProfile profile,
  }) async {
    var parser = UnparsedParser<SleepCommand>();
    var command = SleepCommand(
      parser,
      requester,
      profile,
    );
    try {
      return await command.executeAsync();
    } on KnownException catch (e) {
      throw EnigmaWebException(
        command: command,
        innerException: e,
      );
    }
  }

  static Future<IResponse<IRestartCommand>> restart({
    required IWebRequester requester,
    required IProfile profile,
  }) async {
    var parser = UnparsedParser<RestartCommand>();
    var command = RestartCommand(
      parser,
      requester,
      profile,
    );
    try {
      return await command.executeAsync();
    } on KnownException catch (e) {
      throw EnigmaWebException(
        command: command,
        innerException: e,
      );
    }
  }

  static Future<IGetBouquetsResponse> getBouquets({
    required IWebRequester requester,
    required IProfile profile,
  }) async {
    var parser = GetBouquetsParser();
    var command = GetBouquetsCommand(
      parser,
      requester,
      profile,
    );
    try {
      return await command.executeAsync();
    } on KnownException catch (e) {
      throw EnigmaWebException(
        command: command,
        innerException: e,
      );
    }
  }

  static Future<IGetBouquetItemsResponse> getServices({
    required IWebRequester requester,
    required IProfile profile,
    required IBouquetItemBouquet bouquet,
  }) async {
    var parser = GetBouquetItemsParser();
    var command = GetBouquetItemsCommand(
      parser,
      requester,
      profile,
      bouquet,
    );
    try {
      return await command.executeAsync();
    } on KnownException catch (e) {
      throw EnigmaWebException(
        command: command,
        innerException: e,
      );
    }
  }

  static Future<IGetCurrentServiceResponse> getCurrentService({
    required IWebRequester requester,
    required IProfile profile,
  }) async {
    var parser = GetCurrentServiceParser();
    var command = GetCurrentServiceCommand(
      parser,
      requester,
      profile,
    );
    try {
      return await command.executeAsync();
    } on KnownException catch (e) {
      throw EnigmaWebException(
        command: command,
        innerException: e,
      );
    }
  }

  static Future<IResponse<IZapCommand>> zapService({
    required IWebRequester requester,
    required IProfile profile,
    required IBouquetItemService service,
  }) async {
    var parser = UnparsedParser<ZapCommand>();
    var command = ZapCommand(
      parser,
      requester,
      profile,
      service,
    );

    try {
      return await command.executeAsync();
    } on KnownException catch (e) {
      throw EnigmaWebException(
        command: command,
        innerException: e,
      );
    }
  }

  static Future<ISignalResponse> readSignalLevelMonitor({
    required IWebRequester requester,
    required IProfile profile,
    required IResponseParser<ISignalCommand, SignalResponse> parser,
    required ISignalCommand command,
  }) async {
    try {
      return await command.executeAsync();
    } on KnownException catch (e) {
      throw EnigmaWebException(
        command: command,
        innerException: e,
      );
    }
  }

  static Future<IGetCurrentServiceResponse> getCurrentServiceMonitor({
    required IWebRequester requester,
    required IProfile profile,
    required
        IResponseParser<IGetCurrentServiceCommand, IGetCurrentServiceResponse>
            parser,
    required IGetCurrentServiceCommand command,
  }) async {
    try {
      return await command.executeAsync();
    } on KnownException catch (e) {
      throw EnigmaWebException(
        command: command,
        innerException: e,
      );
    }
  }

  static Future<IScreenshotResponse> getScreenShotOfCurrentService({
    required IWebRequester requester,
    required IProfile profile,
    required ScreenshotType screenshotType,
  }) async {
    var command = ScreenshotCommand(
      requester,
      profile,
      screenshotType,
    );
    try {
      return await command.executeAsync();
    } on KnownException catch (e) {
      throw EnigmaWebException(
        command: command,
        innerException: e,
      );
    }
  }

  static Future<IResponse<IRemoteControlCommand>> sendRemoteControlCode({
    required IWebRequester requester,
    required IProfile profile,
    required RemoteControlCode code,
  }) async {
    var parser = UnparsedParser<RemoteControlCommand>();
    var command = RemoteControlCommand(
      parser,
      requester,
      profile,
      code,
    );
    try {
      return await command.executeAsync();
    } on KnownException catch (e) {
      throw EnigmaWebException(
        command: command,
        innerException: e,
      );
    }
  }

  static Future<IResponse<IMessageCommand>> sendMessage({
    required IWebRequester requester,
    required IProfile profile,
    required String message,
    required Duration timeout,
    required MessageType type,
  }) async {
    var parser = UnparsedParser<MessageCommand>();
    var command = MessageCommand(
        parser, requester, profile, message, timeout.inSeconds, type);
    try {
      return await command.executeAsync();
    } on KnownException catch (e) {
      throw EnigmaWebException(
        command: command,
        innerException: e,
      );
    }
  }
}
