import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/test/mock/mock_server.dart';
import 'package:http/http.dart' as http;

void main() {
  late MockServer _mockServer;

  setUp(() {
    _mockServer = MockServer();
    _mockServer.setupMockResponses();
  });

  testWidgets('passdriver integration test with mock server', (tester) async {
    final client = _mockServer.getClient();
    final response = await client.get(Uri.parse('https://construcao-criativa.workers.dev/api/artifact'),
      headers: {'Authorization': 'Bearer valid-token'}
    );
    expect(response.statusCode, 200);
    expect(response.body, '{"artifact": "mock-artifact"}');
  });
}
