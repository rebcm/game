import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('collision test at high coordinates', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Navigate to the game screen
    await tester.tap(find.text('Start Game'));
    await tester.pumpAndSettle();

    // Move to high coordinates
    await tester.drag(find.byType(GameScreen), Offset(-10000, -10000));
    await tester.pumpAndSettle();

    // Test collision detection
    expect(find.text('Collision Detected'), findsOneWidget);
  });
}
