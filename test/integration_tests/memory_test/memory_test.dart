import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Memory test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Trigger GC manually
    await tester.binding.convertFlutterSurfaceToImage();
    await tester.binding.setSurfaceSize(Size.zero);
    await tester.pumpAndSettle();
    await tester.binding.convertFlutterSurfaceToImage();
    await tester.binding.setSurfaceSize(tester.binding.window.physicalSize);
    await tester.pumpAndSettle();

    // Perform memory-intensive operations
    for (int i = 0; i < 10; i++) {
      await tester.tap(find.text('Build'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Destroy'));
      await tester.pumpAndSettle();
    }

    // Trigger GC again
    await tester.binding.convertFlutterSurfaceToImage();
    await tester.binding.setSurfaceSize(Size.zero);
    await tester.pumpAndSettle();
    await tester.binding.convertFlutterSurfaceToImage();
    await tester.binding.setSurfaceSize(tester.binding.window.physicalSize);
    await tester.pumpAndSettle();
  });
}
