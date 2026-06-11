import 'package:enigma_signal_meter/src/utils/vlc_launcher.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('findVlcPath', () {
    test('returns vlc.exe from registry InstallDir when present', () {
      final path = VlcLauncher.findVlcPath(
        readInstallDir: (keyPath) =>
            keyPath == r'SOFTWARE\VideoLAN\VLC' ? r'D:\Apps\VLC' : null,
        fileExists: (path) => path == r'D:\Apps\VLC\vlc.exe',
      );
      expect(path, r'D:\Apps\VLC\vlc.exe');
    });

    test('falls back to the WOW6432Node registry key', () {
      final path = VlcLauncher.findVlcPath(
        readInstallDir: (keyPath) =>
            keyPath == r'SOFTWARE\WOW6432Node\VideoLAN\VLC'
                ? r'D:\Apps\VLC32'
                : null,
        fileExists: (path) => path == r'D:\Apps\VLC32\vlc.exe',
      );
      expect(path, r'D:\Apps\VLC32\vlc.exe');
    });

    test('falls back to standard install paths when registry is empty', () {
      final path = VlcLauncher.findVlcPath(
        readInstallDir: (_) => null,
        fileExists: (path) =>
            path == r'C:\Program Files\VideoLAN\VLC\vlc.exe',
      );
      expect(path, r'C:\Program Files\VideoLAN\VLC\vlc.exe');
    });

    test('ignores a registry dir whose vlc.exe does not exist', () {
      final path = VlcLauncher.findVlcPath(
        readInstallDir: (keyPath) =>
            keyPath == r'SOFTWARE\VideoLAN\VLC' ? r'D:\Gone' : null,
        fileExists: (path) =>
            path == r'C:\Program Files\VideoLAN\VLC\vlc.exe',
      );
      expect(path, r'C:\Program Files\VideoLAN\VLC\vlc.exe');
    });

    test('returns null when VLC is nowhere to be found', () {
      final path = VlcLauncher.findVlcPath(
        readInstallDir: (_) => null,
        fileExists: (_) => false,
      );
      expect(path, isNull);
    });
  });
}
