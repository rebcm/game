import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:http/http.dart' as http;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('integration test against staging API', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final response = await http.get(Uri.parse(const String.fromEnvironment('API_URL')));
    expect(response.statusCode, 200);
  });
}
