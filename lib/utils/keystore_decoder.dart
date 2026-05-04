import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class KeystoreDecoder {
  static Future<void> decodeKeystore(String base64Keystore, String outputPath) async {
    final Uint8List keystoreBytes = base64Decode(base64Keystore);
    final File outputFile = File(outputPath);
    await outputFile.writeAsBytes(keystoreBytes);
  }
}
