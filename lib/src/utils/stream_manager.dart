import 'package:enigma_signal_meter/src/model/enigma_web_exception.dart';
import 'package:enigma_signal_meter/src/utils/enigma_api.dart';
import 'package:enigma_signal_meter/src/utils/network_utils.dart';
import 'package:enigma_web/enigma_web.dart';
import 'package:logging/logging.dart';

class StreamUtils {
  static Future<StreamParametersResponse> getStreamUrl(
    IProfile profile,
    IBouquetItemService service,
  ) async {
    StreamParametersResponseStatus? status;
    int? port;

    if (profile.transcoding) {
      port = await _findTranscodingPort(profile);
      if (port != null) {
        status = StreamParametersResponseStatus.UsingTranscodingPort;
      }
    }

    if (port == null) {
      //no transcoding port, fallback to streaming port
      port = await _findStreamingPort(profile);
      if (port != null) {
        status = StreamParametersResponseStatus.UsingStreamingPort;
      } else {
        if (profile.transcoding) {
          status =
              StreamParametersResponseStatus.TranscodingStreamingPortClosed;
        } else {
          status = StreamParametersResponseStatus.StreamingPortClosed;
        }
      }
    }

    Uri? extraParametersUri;
    EnigmaWebException? webException;
    if (_needExtraStreamParameters(profile, port)) {
      try {
        extraParametersUri = await _getExtraParametersUri(profile, service);
        if (extraParametersUri == null) {
          status = StreamParametersResponseStatus.FailedToGetExtraParameters;
        }
      } on EnigmaWebException catch (e) {
        webException = e;
        status = StreamParametersResponseStatus.FailedToGetExtraParameters;
      }
    }

    if (status == StreamParametersResponseStatus.FailedToGetExtraParameters) {
      return StreamParametersResponse(
        status: status!,
        getStreamParametersError: webException,
        streamUri: null,
      );
    }

    if (port == null) {
      port = await _findExtraParametersPort(profile, extraParametersUri);
      if (port != null) {
        status = StreamParametersResponseStatus.UsingExtraParametersPort;
      }
    }

    if (port == null) {
      return StreamParametersResponse(
        status: status!,
        getStreamParametersError: webException,
        streamUri: null,
      );
    }

    String streamUri;
    if (profile.enigma == EnigmaType.enigma2) {
      //http://example.com:8001/
      streamUri = 'http://${profile.address}:$port/${service.reference}';
    } else {
      //http://dm600pvr:31339/0,61,1ff,200
      streamUri = 'http://${profile.address}:$port${extraParametersUri!.path}';
    }
    streamUri = Uri.encodeFull(streamUri);
    return StreamParametersResponse(
      status: status!,
      getStreamParametersError: null,
      streamUri: streamUri,
    );
  }

  static Future<int?> _findTranscodingPort(IProfile profile) async {
    //check if transcoding port is available
    final transcodingPort = profile.transcodingPort;
    if (transcodingPort == null) return null;
    if (await NetworkUtils.isPortOpen(
      profile.address,
      transcodingPort,
    )) {
      return transcodingPort;
    } else if (transcodingPort != 8002 &&
        await NetworkUtils.isPortOpen(profile.address, 8002)) {
      return 8002;
    }
    return null;
  }

  static Future<int?> _findStreamingPort(IProfile profile) async {
    //check if streaming port is available
    final streamingPort = profile.streamingPort;
    if (streamingPort == null) return null;
    if (await NetworkUtils.isPortOpen(
      profile.address,
      streamingPort,
    )) {
      return streamingPort;
    } else if (profile.enigma == EnigmaType.enigma2 &&
        streamingPort != 8001 &&
        await NetworkUtils.isPortOpen(profile.address, 8001)) {
      return 8001;
    }
    return null;
  }

  static bool _needExtraStreamParameters(
    IProfile profile,
    int? port,
  ) {
    return profile.enigma == EnigmaType.enigma1 || port == null;
  }

  static Future<Uri?> _getExtraParametersUri(
    IProfile profile,
    IBouquetItemService service,
  ) async {
    var extraParameters = await EnigmaApi.getStreamParameters(
      requester: WebRequester(Logger.root),
      profile: profile,
      service: service,
    );
    if (extraParameters == null || extraParameters.streamUrl.isEmpty) {
      return null;
    }
    return Uri.parse(extraParameters.streamUrl);
  }

  static Future<int?> _findExtraParametersPort(
      IProfile profile, Uri? extraParametersUri) async {
    if (extraParametersUri == null) return null;
    if (await NetworkUtils.isPortOpen(
      profile.address,
      extraParametersUri.port,
    )) {
      return extraParametersUri.port;
    }
    return null;
  }
}

class StreamParametersResponse {
  final StreamParametersResponseStatus status;
  final String? streamUri;
  final EnigmaWebException? getStreamParametersError;

  StreamParametersResponse({
    required this.status,
    required this.streamUri,
    required this.getStreamParametersError,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StreamParametersResponse &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          streamUri == other.streamUri &&
          getStreamParametersError == other.getStreamParametersError;

  @override
  int get hashCode =>
      status.hashCode ^ streamUri.hashCode ^ getStreamParametersError.hashCode;
}

enum StreamParametersResponseStatus {
  UsingTranscodingPort,
  UsingStreamingPort,
  UsingExtraParametersPort,
  FailedToGetExtraParameters,
  TranscodingStreamingPortClosed,
  StreamingPortClosed,
}
