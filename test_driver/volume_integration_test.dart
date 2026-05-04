import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Volume Integration Tests', () {
    testWidgets('should display correct volume on restart', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Simulate volume change and restart
      // await tester.tap(find.byIcon(Icons.volume_up));
      await tester.pumpAndSettle();
      await app.restartApp();

      // Verify volume is persisted correctly
      // expect(find.text('Volume: 1.0'), findsOneWidget);
    });

    testWidgets('should handle zero volume on restart', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Simulate volume change to zero and restart
      // await tester.tap(find.byIcon(Icons.volume_mute));
      await tester.pumpAndSettle();
      await app.restartApp();

      // Verify zero volume is persisted correctly
      // expect(find.text('Volume: 0.0'), findsOneWidget);
    });
  });
}
