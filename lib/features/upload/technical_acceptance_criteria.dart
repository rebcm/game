import 'package:crypto/crypto.dart';
import 'dart:convert';

class TechnicalAcceptanceCriteria {
  bool verifyChecksum(String filePath, String expectedChecksum) {
    var file = File(filePath);
    var bytes = file.readAsBytesSync();
    var digest = sha256.convert(bytes);
    return digest.toString() == expectedChecksum;
  }

  bool validateUploadStatus(String status) {
    return status == 'uploaded';
  }
}
