import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:http/http.dart' as http;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Smoke test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final response = await http.get(Uri.parse('http://localhost:8080'));
    expect(response.statusCode, 200);

    final flutterView = tester.widgetList(find.byType(FlutterView));
    expect(flutterView, isNotEmpty);
  });
}
