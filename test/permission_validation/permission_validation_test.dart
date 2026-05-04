import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/permission_service.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('Permission Validation Tests', () {
    late http.Client client;
    late PermissionService permissionService;

    setUp(() {
      client = MockHttpClient();
      permissionService = PermissionService(client);
    });

    test('should succeed when permission is granted', () async {
      when(client.get(Uri.parse('https://example.com/api/test')))
          .thenAnswer((_) async => http.Response('Success', 200));

      final result = await permissionService.makeRequest();

      expect(result.statusCode, 200);
    });

    test('should fail with 403 when permission is not granted', () async {
      when(client.get(Uri.parse('https://example.com/api/test')))
          .thenAnswer((_) async => http.Response('Forbidden', 403));

      final result = await permissionService.makeRequest();

      expect(result.statusCode, 403);
    });
  });
}
