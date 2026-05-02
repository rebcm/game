import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/cloudflare_api/cloudflare_api_client.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import '../mock_server/mock_cloudflare_api_server.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late http.Client httpClient;
  late CloudflareApiClient cloudflareApiClient;

  setUp(() {
    httpClient = MockHttpClient();
    cloudflareApiClient = CloudflareApiClient(httpClient);
  });

  test('should return 401 when token is expired', () async {
    when(() => httpClient.get(any())).thenAnswer((_) async => await MockCloudflareApiServer.handleRequest(http.Request('GET', Uri.parse('https://example.com/token-expired'))));
    final response = await cloudflareApiClient.makeRequest(Uri.parse('https://example.com/token-expired'));
    expect(response.statusCode, 401);
  });

  test('should return 503 when there is a connection failure', () async {
    when(() => httpClient.get(any())).thenAnswer((_) async => await MockCloudflareApiServer.handleRequest(http.Request('GET', Uri.parse('https://example.com/connection-failure'))));
    final response = await cloudflareApiClient.makeRequest(Uri.parse('https://example.com/connection-failure'));
    expect(response.statusCode, 503);
  });

  test('should return 413 when payload is too large', () async {
    when(() => httpClient.get(any())).thenAnswer((_) async => await MockCloudflareApiServer.handleRequest(http.Request('GET', Uri.parse('https://example.com/payload-too-large'))));
    final response = await cloudflareApiClient.makeRequest(Uri.parse('https://example.com/payload-too-large'));
    expect(response.statusCode, 413);
  });
}
