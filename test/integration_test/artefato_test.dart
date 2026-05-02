import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:http/http.dart' as http;
import 'package:rebcm/main.dart' as app;
import '../mock_server/mock_server.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Artefato Test', () {
    late MockServer _mockServer;

    setUp(() async {
      _mockServer = MockServer();
      await _mockServer.start();
    });

    tearDown(() async {
      await _mockServer.stop();
    });

    testWidgets('401 Unauthorized', (tester) async {
      await app.main();
      await tester.pumpAndSettle();
      final response = await http.get(Uri.parse('http://localhost:8080/401'));
      expect(response.statusCode, 401);
    });

    testWidgets('507 Insufficient Storage', (tester) async {
      await app.main();
      await tester.pumpAndSettle();
      final response = await http.get(Uri.parse('http://localhost:8080/507'));
      expect(response.statusCode, 507);
    });
  });
}
