import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockHttpClient extends Mock implements http.Client {}

void setUpMockHttpClient(MockHttpClient client) {
  when(client.get(Uri.parse('https://example.com/api/data')))
      .thenAnswer((_) async => http.Response('{"data": "mocked"}', 200));
}
