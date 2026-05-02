import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:http/http.dart' as http;
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('API Integration Tests', () {
    testWidgets('Test API endpoint', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final response = await http.get(Uri.parse('https://api.example.com/endpoint'));
      expect(response.statusCode, 200);
    });

    testWidgets('Test API error handling', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      try {
        await http.get(Uri.parse('https://api.example.com/non-existent-endpoint'));
        fail('Expected exception not thrown');
      } catch (e) {
        expect(e, isA<http.ClientException>());
      }
    });
  });
}
