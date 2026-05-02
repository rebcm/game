import 'package:crypto/crypto.dart';
import 'dart:convert';

class AssinaturaValidator {
  static bool validateViaChecksum(String apkPath, String expectedChecksum) {
    var bytes = File(apkPath).readAsBytesSync();
    var digest = sha256.convert(bytes);
    return digest.toString() == expectedChecksum;
  }
}
