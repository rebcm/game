import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:http/http.dart' as http;
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('API Integration Tests', () {
    testWidgets('Testa requisição bem-sucedida', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      final response = await http.get(Uri.parse('https://api.example.com/endpoint'));
      expect(response.statusCode, 200);
    });

    testWidgets('Testa requisição mal-sucedida', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      final response = await http.get(Uri.parse('https://api.example.com/endpoint-inexistente'));
      expect(response.statusCode, 404);
    });

    testWidgets('Testa tratamento de exceção', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      try {
        await http.get(Uri.parse('https://api.example.com/endpoint-com-erro'));
      } catch (e) {
        expect(e, isNotNull);
      }
    });
  });
}
