import 'package:http/http.dart' as http;
import 'package:http_mock/http_mock.dart';

class ApiMock {
  static void setupMockClient(MockClient mockClient) {
    mockClient.onGet(
      Uri.parse('https://construcao-criativa.workers.dev/api/mundos'),
      (request) => http.Response('[]', 200),
    );

    mockClient.onPost(
      Uri.parse('https://construcao-criativa.workers.dev/api/mundos'),
      (request) => http.Response('{"id": "123"}', 201),
    );

    mockClient.onGet(
      Uri.parse('https://construcao-criativa.workers.dev/api/mundos/123'),
      (request) => http.Response('{"id": "123", "data": "mocked"}', 200),
    );
  }
}
