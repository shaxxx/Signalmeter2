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
      address: this.address,
      enigma: this.enigma,
      httpPort: int.parse(this.httpPort),
      id: this.id ?? EnigmaUtils.unixTimeStamp(),
      name: this.name,
      password: this.password,
      streaming: this.streaming,
      streamingPort: this.streaming && this.enigma == EnigmaType.enigma2
          ? int.parse(this.streamingPort)
          : null,
      transcoding: this.transcoding,
      transcodingPort: this.transcoding && this.enigma == EnigmaType.enigma2
          ? int.parse(this.transcodingPort)
          : null,
      username: this.username,
      useSsl: this.useSsl,
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
