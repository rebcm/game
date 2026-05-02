import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Onboarding test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Validate onboarding checklist steps
    expect(find.text('Welcome to Rebeca\'s World!'), findsOneWidget);
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Build and explore!'), findsOneWidget);
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();

    // Add more steps as necessary based on the onboarding checklist
  });
}
