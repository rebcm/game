import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:dio/dio.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('API Tests', () {
    testWidgets('Test API Connection', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      final dio = Dio();
      final response = await dio.get('https://example.com/api/healthcheck');
      expect(response.statusCode, 200);
    });

    testWidgets('Test API Authentication', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      final dio = Dio();
      final response = await dio.post('https://example.com/api/login', data: {'username': 'test', 'password': 'test'});
      expect(response.statusCode, 200);
    });

    testWidgets('Test API Load Test', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      final dio = Dio();
      for (var i = 0; i < 100; i++) {
        final response = await dio.get('https://example.com/api/healthcheck');
        expect(response.statusCode, 200);
      }
    });
  });
}
