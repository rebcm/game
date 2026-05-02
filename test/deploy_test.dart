import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Deployment test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Verify app is rendered correctly
    expect(find.text('Rebeca'), findsOneWidget);

    // Verify assets are loaded
    // Add asset verification logic here

    // Verify build time is within limit
    // Add build time verification logic here
  });
}
