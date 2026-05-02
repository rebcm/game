import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:rebcm/services/compression_service.dart';

void main() {
  test('Compression handshake interoperability test', () async {
    final compressionService = CompressionService();
    final response = await http.get(Uri.parse('https://example.com/api/test'));
    expect(compressionService.isCompressionSupported(response.headers), true);
  });
}
