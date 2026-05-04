import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/keystore_decoder.dart';
import 'dart:convert';
import 'dart:io';

void main() {
  test('decodeKeystore decodes base64 string to file', () {
    final base64Keystore = 'SGVsbG8gd29ybGQ='; // Hello world in base64
    final outputPath = 'test_keystore.jks';
    KeystoreDecoder.decodeKeystore(base64Keystore, outputPath);
    final file = File(outputPath);
    expect(file.existsSync(), true);
    expect(file.readAsBytesSync(), base64Decode(base64Keystore));
    file.deleteSync();
  });
}
