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
    await Future.delayed(const Duration(seconds: 2));
    await tester.binding.convertFlutterSurfaceToImage();
    await tester.binding.setSurfaceTextureIsolate();
    await Future.delayed(const Duration(seconds: 2));

    // Perform memory-intensive operations
    for (int i = 0; i < 5; i++) {
      await tester.tap(find.text('Build'));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 1));
    }

    // Trigger GC again
    await tester.binding.convertFlutterSurfaceToImage();
    await tester.binding.setSurfaceTextureIsolate();
    await Future.delayed(const Duration(seconds: 2));
  });
}
