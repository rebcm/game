import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class ChecksumService {
  Future<String> calculateMd5(Uint8List data) async {
    return md5.convert(data).toString();
  }

  Future<bool> verifyChecksum(String url, String expectedChecksum) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Uint8List data = response.bodyBytes;
      final String actualChecksum = await calculateMd5(data);
      return actualChecksum == expectedChecksum;
    } else {
      return false;
    }
  }
}
