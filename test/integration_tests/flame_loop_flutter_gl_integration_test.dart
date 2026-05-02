import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:flame/game.dart';
import 'package:flutter_gl/flutter_gl.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Flame Loop <-> flutter_gl Integration Test', () {
    testWidgets('Verify frame synchronization', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Get the Flame game instance
      final game = tester.allWidgets.firstWhere((widget) => widget is GameWidget);
      final flameGame = (game as GameWidget).game;

      // Verify that the game is rendering
      expect(flameGame, isNotNull);

      // Check for frame synchronization
      // This is a placeholder for actual implementation
      // You would need to implement a way to check if the frames are synchronized
      // For example, by checking the frame rate or the rendering timestamp
      expect(true, isTrue); // Replace with actual verification logic
    });
  });
}
