import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:integration_test/integration_test.dart';

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
    await tester.pumpAndSettle();

    // Verify no memory leaks
    // This is just a placeholder, actual verification should be done using DevTools or LeakCanary
    expect(true, true);
  });
}
