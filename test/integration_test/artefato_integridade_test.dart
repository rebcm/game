import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Artefato integridade test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Test logic for valid artifact
    await tester.pumpAndSettle();
    expect(find.text('Rebeca'), findsOneWidget);

    // Test logic for corrupted artifact
    // Simulate corruption
    await tester.pumpAndSettle();
    expect(find.text('Error'), findsOneWidget);
  });
}
