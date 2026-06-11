import 'dart:io';

import 'package:enigma_signal_meter/src/utils/install_dir_access.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isDirWritable', () {
    test('returns true for a writable directory', () async {
      final tempDir =
          await Directory.systemTemp.createTemp('install_dir_access');
      addTearDown(() => tempDir.delete(recursive: true));

      expect(await isDirWritable(tempDir), isTrue);
    });

    test('leaves no probe file behind', () async {
      final tempDir =
          await Directory.systemTemp.createTemp('install_dir_access');
      addTearDown(() => tempDir.delete(recursive: true));

      await isDirWritable(tempDir);

      expect(tempDir.listSync(), isEmpty);
    });

    test('returns false for a non-existent directory', () async {
      final missing = Directory(
        '${Directory.systemTemp.path}${Platform.pathSeparator}no_such_dir_12345',
      );
      expect(await isDirWritable(missing), isFalse);
    });
  });
}
