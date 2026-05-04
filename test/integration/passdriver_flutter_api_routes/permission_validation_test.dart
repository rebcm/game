import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:dio/dio.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Testa permissão concedida', (tester) async {
    await app.main();
    await tester.pumpAndSettle();
    final dio = Dio();
    final response = await dio.get('/api/route');
    expect(response.statusCode, 200);
  });

  testWidgets('Testa permissão negada', (tester) async {
    await app.main();
    await tester.pumpAndSettle();
    final dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer invalid_token';
    final response = await dio.get('/api/route');
    expect(response.statusCode, 403);
  });
}
