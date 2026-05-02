import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:http/http.dart' as http;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('test request timeout', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    // Simulate API latency
    await Future.delayed(Duration(seconds: 30));

    // Check if timeout error is handled
    expect(find.text('Timeout Error'), findsOneWidget);
  });
}
