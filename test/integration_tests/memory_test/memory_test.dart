import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Memory test for garbage collection', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Trigger garbage collection multiple times
    for (var i = 0; i < 5; i++) {
      await tester.binding.convertFlutterSurfaceToImage();
      await tester.binding.setSurfacePixelRatio(1.0);
      await tester.pumpAndSettle(Duration(seconds: 2));
      await tester.binding.collectGarbage();
      await Future.delayed(Duration(seconds: 1));
    }

    // Verify that the heap is clean
    expect(await tester.binding.getNativeHeapSize(), lessThan(100000000));
  });
}
