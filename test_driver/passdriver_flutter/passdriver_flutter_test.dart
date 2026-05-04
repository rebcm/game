import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:dio/dio.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  Dio dio = Dio();

  testWidgets('Test API routes with least privilege token', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Add test logic here to validate API routes with least privilege token
    final response = await dio.get('/api/example');
    expect(response.statusCode, 200);
  });
}
