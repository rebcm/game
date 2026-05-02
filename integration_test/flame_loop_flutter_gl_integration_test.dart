import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:flame/game.dart';
import 'package:flutter_gl/flutter_gl.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Verify frame synchronization between Flame and OpenGL', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Assuming there's a way to access the Flame game instance
    // and the FlutterGL context directly or through the app's widgets.
    // This is a simplified example and actual implementation may vary.
    final game = tester.allWidgets.firstWhere((widget) => widget is GameWidget);
    final flutterGlContext = tester.allWidgets.firstWhere((widget) => widget is FlutterGL);

    // Check if the game loop and OpenGL rendering are synchronized.
    // The exact method to check synchronization may depend on the implementation.
    expect(game.game.updateCount, flutterGlContext.renderCount);
  });
}
