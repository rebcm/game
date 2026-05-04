import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class KeystoreDecoder {
  static Future<void> decodeKeystore(String base64Keystore, String outputPath) async {
    final Uint8List keystoreBytes = base64Decode(base64Keystore);
    final File outputFile = File(outputPath);
    await outputFile.writeAsBytes(keystoreBytes);
  }

  static Future<void> decodeP12Certificate(String base64Certificate, String outputPath) async {
    final Uint8List certificateBytes = base64Decode(base64Certificate);
    final File outputFile = File(outputPath);
    await outputFile.writeAsBytes(certificateBytes);
  }
}
