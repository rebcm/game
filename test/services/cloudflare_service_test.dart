import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/cloudflare_service.dart';
import 'package:http/http.dart' as http;

void main() {
  group('CloudflareService', () {
    test('should throw exception when token is invalid', () async {
      final service = CloudflareService();
      final response = http.Response('Forbidden', 403);

      expect(() async => await service.handleTokenError(response), throwsException);
    });
  });
}
