import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Undo/Redo performance test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Perform a series of undo and redo operations
    for (int i = 0; i < 10; i++) {
      // Simulate a block placement
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Undo the block placement
      await tester.sendKeyEvent(LogicalKeyboardKey.controlLeft);
      await tester.sendKeyEvent(LogicalKeyboardKey.keyZ);
      await tester.pumpAndSettle();

      // Redo the block placement
      await tester.sendKeyEvent(LogicalKeyboardKey.controlLeft);
      await tester.sendKeyEvent(LogicalKeyboardKey.keyY);
      await tester.pumpAndSettle();
    }

    // Measure the rebuild count
    final rebuildCount = tester.binding.hasWidgetRenderObject(find.byType(GridView));

    expect(rebuildCount, lessThan(50));
  });
}
