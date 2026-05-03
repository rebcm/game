import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('debug overlay is visible when enabled', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final debugButton = find.byIcon(Icons.bug_report);
    await tester.tap(debugButton);
    await tester.pumpAndSettle();

    final debugOverlay = find.text('Debug Mode');
    expect(debugOverlay, findsOneWidget);
  });
}
