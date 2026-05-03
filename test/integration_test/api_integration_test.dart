import 'package:flutter_test/flutter_test.dart';
import 'package:game/mock_api/mock_api.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

void main() {
  group('API Integration Test', () {
    late MockHttpClient client;

    setUp(() {
      client = MockHttpClient();
      setUpMockHttpClient(client);
    });

    testWidgets('uses mock API', (tester) async {
      final response = await client.get(Uri.parse('https://example.com/api/data'));
      expect(response.statusCode, 200);
      expect(response.body, '{"data": "mocked"}');
    });
  });
}
