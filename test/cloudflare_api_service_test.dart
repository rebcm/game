import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:rebcm/services/cloudflare_api/cloudflare_api_service.dart';
import '../mock_server/mock_cloudflare_api_server.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late CloudflareApiService cloudflareApiService;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    cloudflareApiService = CloudflareApiService();
    MockCloudflareApiServer.setupMockResponses();
  });

  test('should return 200 when posting to Cloudflare API', () async {
    when(() => mockHttpClient.post(any(), headers: any(named: 'headers'), body: any(named: 'body'))).thenAnswer((_) async {
      return http.Response('{"success": true}', 200);
    });

    final response = await cloudflareApiService.post('https://api.cloudflare.com/client/v4/accounts/account_id/storage/kv/namespaces/namespace_id/values/key', {'Authorization': 'Bearer valid_token'}, '{"key": "value"}');

    expect(response.statusCode, 200);
  });

  test('should return 401 when token is expired', () async {
    when(() => mockHttpClient.post(any(), headers: any(named: 'headers'), body: any(named: 'body'))).thenAnswer((_) async {
      return http.Response('{"success": false, "errors": [{"code": 10000, "message": "Authentication error"}]}', 401);
    });

    final response = await cloudflareApiService.post('https://api.cloudflare.com/client/v4/accounts/account_id/storage/kv/namespaces/namespace_id/values/key', {'Authorization': 'Bearer expired_token'}, '{"key": "value"}');

    expect(response.statusCode, 401);
  });

  test('should return 413 when payload is too large', () async {
    when(() => mockHttpClient.post(any(), headers: any(named: 'headers'), body: any(named: 'body'))).thenAnswer((_) async {
      return http.Response('{"success": false, "errors": [{"code": 413, "message": "Payload too large"}]}', 413);
    });

    final response = await cloudflareApiService.post('https://api.cloudflare.com/client/v4/accounts/account_id/storage/kv/namespaces/namespace_id/values/key', {'Authorization': 'Bearer valid_token'}, '{"large": "payload"}'*10000);

    expect(response.statusCode, 413);
  });

  test('should return 503 when service is unavailable', () async {
    when(() => mockHttpClient.post(any(), headers: any(named: 'headers'), body: any(named: 'body'))).thenAnswer((_) async {
      return http.Response('{"success": false, "errors": [{"code": 503, "message": "Service unavailable"}]}', 503);
    });

    final response = await cloudflareApiService.post('https://api.cloudflare.com/client/v4/accounts/account_id/storage/kv/namespaces/namespace_id/values/key', {'Authorization': 'Bearer valid_token'}, '{"key": "value"}');

    expect(response.statusCode, 503);
  });
}
