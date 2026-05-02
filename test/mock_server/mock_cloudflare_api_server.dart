import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockCloudflareApiServer {
  static void setupMockResponses() {
    when(() => http.post(
      Uri.parse('https://api.cloudflare.com/client/v4/accounts/account_id/storage/kv/namespaces/namespace_id/values/key'),
      headers: any(named: 'headers'),
      body: any(named: 'body'),
    )).thenAnswer((_) async {
      return http.Response('{"success": true}', 200);
    });

    when(() => http.post(
      Uri.parse('https://api.cloudflare.com/client/v4/accounts/account_id/storage/kv/namespaces/namespace_id/values/key'),
      headers: any(named: 'headers'),
      body: any(named: 'body'),
    )).thenThrow(Exception('Mocked exception'));

    when(() => http.post(
      Uri.parse('https://api.cloudflare.com/client/v4/accounts/account_id/storage/kv/namespaces/namespace_id/values/key'),
      headers: {'Authorization': 'Bearer expired_token'},
      body: any(named: 'body'),
    )).thenAnswer((_) async {
      return http.Response('{"success": false, "errors": [{"code": 10000, "message": "Authentication error"}]}', 401);
    });

    when(() => http.post(
      Uri.parse('https://api.cloudflare.com/client/v4/accounts/account_id/storage/kv/namespaces/namespace_id/values/key'),
      headers: any(named: 'headers'),
      body: '{"large": "payload"}'*10000,
    )).thenAnswer((_) async {
      return http.Response('{"success": false, "errors": [{"code": 413, "message": "Payload too large"}]}', 413);
    });

    when(() => http.post(
      Uri.parse('https://api.cloudflare.com/client/v4/accounts/account_id/storage/kv/namespaces/namespace_id/values/key'),
      headers: any(named: 'headers'),
      body: any(named: 'body'),
    )).thenAnswer((_) async {
      return http.Response('{"success": false, "errors": [{"code": 503, "message": "Service unavailable"}]}', 503);
    });
  }
}
