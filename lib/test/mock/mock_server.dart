import 'package:http/http.dart' as http;
import 'package:http_mock/http_mock.dart';

class MockServer {
  final MockHttpClient _client = MockHttpClient();

  void setupMockResponses() {
    _client.onGet('https://construcao-criativa.workers.dev/api/artifact')
      ..when((request) => request.headers['Authorization'] == 'Bearer valid-token')
        .thenReturn(http.Response('{"artifact": "mock-artifact"}', 200))
      ..when((request) => request.headers['Authorization'] != 'Bearer valid-token')
        .thenReturn(http.Response('Unauthorized', 401));
  }

  http.Client getClient() => _client;
}
