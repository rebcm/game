import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class ChecksumService {
  Future<String> calculateMd5(Uint8List data) async {
    return md5.convert(data).toString();
  }

  Future<bool> validateChecksum(String url, String expectedChecksum) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final checksum = md5.convert(response.bodyBytes).toString();
      return checksum == expectedChecksum;
    } else {
      return false;
    }
  }
}
