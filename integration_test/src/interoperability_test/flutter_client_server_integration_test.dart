import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:dio/dio.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('validate Flutter client and server integration', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final dio = Dio();
    final response = await dio.get('https://example.com/api/endpoint');

    expect(response.statusCode, 200);
  });
}
