import 'package:enigma_signal_meter/src/utils/enigma_utils.dart';
import 'package:enigma_web/enigma_web.dart';

class ProfileEditModel {
  String address;
  EnigmaType enigma = EnigmaType.enigma2;
  String httpPort;
  String name;
  String password;
  bool useSsl = false;
  String username;
  String streamingPort;
  bool transcoding = false;
  String transcodingPort;
  bool streaming = false;
  String id;

  Profile toProfile() {
    return Profile(
      address: address,
      enigma: enigma,
      httpPort: int.parse(httpPort),
      id: id ?? EnigmaUtils.unixTimeStamp(),
      name: name,
      password: password ?? '',
      streaming: streaming,
      streamingPort: streaming && enigma == EnigmaType.enigma2
          ? int.parse(streamingPort)
          : null,
      transcoding: streaming && transcoding,
      transcodingPort: streaming && transcoding && enigma == EnigmaType.enigma2
          ? int.parse(transcodingPort)
          : null,
      username: username,
      useSsl: useSsl,
    );
  }

  static ProfileEditModel fromProfile(Profile profile) {
    var model = ProfileEditModel();
    model.address = profile.address;
    model.enigma = profile.enigma;
    model.httpPort = profile.httpPort.toString() ?? '';
    model.id = profile.id;
    model.name = profile.name;
    model.password = profile.password;
    model.useSsl = profile.useSsl;
    model.username = profile.username;
    model.streamingPort = profile.streamingPort?.toString() ?? '';
    model.streaming = profile.streaming;
    model.transcoding = profile.transcoding;
    model.transcodingPort = profile.transcodingPort?.toString() ?? '';
    return model;
  }
}
