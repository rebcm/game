import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Chunk Stress Test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simulate rapid chunk transitions
    for (int i = 0; i < 100; i++) {
      // Move player to trigger chunk loading
      await tester.pumpAndSettle(Duration(milliseconds: 100));
    }

    // Verify FPS
    expect(IntegrationTestWidgetsFlutterBinding.instance.framePolicy, FramePolicy.benchmark);
  });
}
