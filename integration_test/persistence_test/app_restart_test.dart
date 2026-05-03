import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test app restart persistence', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    // Simulate app restart
    await tester.binding.resetBinding();
    await app.main();
    await tester.pumpAndSettle();

    // Verify persistence
    expect(find.text('Expected text after restart'), findsOneWidget);
  });
}
