import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:http/http.dart' as http;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('cleanup test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Perform cleanup actions here
    final response = await http.delete(Uri.parse('https://example.com/api/cleanup'));
    expect(response.statusCode, 200);
  });
}
