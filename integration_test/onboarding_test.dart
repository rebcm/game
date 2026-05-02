import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Onboarding test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Add test steps here to validate onboarding process
    expect(find.text('Rebeca\'s Creative Mode'), findsOneWidget);
  });
}
