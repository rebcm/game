import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Onboarding smoke test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Add test steps for onboarding process here
    // For example:
    // await tester.tap(find.text('Get Started'));
    // await tester.pumpAndSettle();
  });
}
