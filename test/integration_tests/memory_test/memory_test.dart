import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('memory test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Force garbage collection
    await tester.binding.convertFlutterSurfaceToImage();
    await tester.binding.setSurfaceSemantics(false);
    await tester.binding.runAsync(() async {
      await Future.delayed(Duration(seconds: 2));
    });

    // Check for memory leaks
    expect(await tester.binding.getNativeHeapSize(), lessThan(100000000));
  });
}
