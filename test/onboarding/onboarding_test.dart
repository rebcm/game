import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('onboarding test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Validate the initial screen
    expect(find.text('Rebeca Voxel World'), findsOneWidget);

    // Simulate user interactions
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();

    // Validate the world is loaded
    expect(find.byType(GridView), findsOneWidget);
  });
}
