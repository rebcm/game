import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Secrets Test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Implement secret validation logic here
    // For now, just verify the app starts without crashing
    expect(find.text('Rebeca'), findsOneWidget);
  });
}
