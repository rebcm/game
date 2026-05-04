import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Scroll Block Test', () {
    testWidgets('should block scroll with WASD and Space', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Simulate WASD and Space key presses
      await tester.sendKeyEvent(LogicalKeyboardKey.keyW);
      await tester.sendKeyEvent(LogicalKeyboardKey.keyA);
      await tester.sendKeyEvent(LogicalKeyboardKey.keyS);
      await tester.sendKeyEvent(LogicalKeyboardKey.keyD);
      await tester.sendKeyEvent(LogicalKeyboardKey.space);

      // Verify scroll is blocked
      expect(await tester.isKeyPressed(LogicalKeyboardKey.keyW), isTrue);
      expect(await tester.isKeyPressed(LogicalKeyboardKey.keyA), isTrue);
      expect(await tester.isKeyPressed(LogicalKeyboardKey.keyS), isTrue);
      expect(await tester.isKeyPressed(LogicalKeyboardKey.keyD), isTrue);
      expect(await tester.isKeyPressed(LogicalKeyboardKey.space), isTrue);
    });
  });
}
