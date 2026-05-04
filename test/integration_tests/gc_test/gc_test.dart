import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('force GC test', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    // Trigger GC
    await tester.binding.convertFlutterSurfaceToImage();
    await tester.binding.setSurfaceSemantics(true);
    await tester.binding.setSurfaceSemantics(false);
    await tester.binding.convertImageToFlutterSurface();

    // Verify memory usage
    final memoryUsage = await tester.binding.getMemoryUsage();
    print('Memory usage: $memoryUsage');
  });
}
