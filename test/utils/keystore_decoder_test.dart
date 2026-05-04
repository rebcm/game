import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/keystore_decoder.dart';
import 'dart:io';
import 'dart:convert';

void main() {
  test('decodeKeystore decodes base64 string to file', () async {
    final String base64Keystore = 'SGVsbG8gd29ybGQ='; // Hello world in base64
    final String outputPath = 'test_keystore.jks';
    await KeystoreDecoder.decodeKeystore(base64Keystore, outputPath);
    final File outputFile = File(outputPath);
    expect(await outputFile.exists(), true);
    expect(await outputFile.readAsString(), 'Hello world');
    await outputFile.delete();
  });
}
