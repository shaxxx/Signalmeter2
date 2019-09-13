import 'dart:io';

const String ValidIpAddressRegex =
    r"^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$";

const String ValidHostnameRegex =
    r"^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])$";

const String PrivateIpAddressRegex =
    r"(^127\.)|(^192\.168\.)|(^10\.)|(^172\.1[6-9]\.)|(^172\.2[0-9]\.)|(^172\.3[0-1]\.)|(^::1$)|(^[fF][cCdD])";

class NetworkUtils {
  static bool isValidAddress(String address) {
    if (address == null || address.isEmpty) {
      return false;
    }
    return RegExp(ValidHostnameRegex).hasMatch(address);
  }

  static bool isLocalIp(String address) {
    if (address == null || address.isEmpty) {
      return false;
    }
    return RegExp(PrivateIpAddressRegex).hasMatch(address);
  }

  static bool isStringValidPort(String port) {
    if (port == null || port.length < 2 || port.length > 5) {
      return false;
    }
    var intValue = int.tryParse(port);
    if (intValue == null) {
      return false;
    }
    return isValidPort(intValue);
  }

  static bool isValidPort(int port) {
    if (port > 65535 || port < 1) {
      return false;
    }
    return true;
  }

  static Future<bool> isPortOpen(String address, int port) async {
    bool isOpen;
    try {
      await Socket.connect(
        address,
        port,
        timeout: Duration(seconds: 3),
      ).then(
        (socket) {
          isOpen = true;
          socket.destroy();
        },
      );
    } catch (e) {
      isOpen = false;
    }
    return isOpen;
  }
}
