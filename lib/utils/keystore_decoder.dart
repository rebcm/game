import 'dart:convert';
import 'dart:io';

class KeystoreDecoder {
  static void decodeKeystore(String base64Keystore, String outputPath) {
    final decodedKeystore = base64Decode(base64Keystore);
    File(outputPath).writeAsBytesSync(decodedKeystore);
  }
}
