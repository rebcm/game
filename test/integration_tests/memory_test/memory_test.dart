import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('memory test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Perform actions to test memory
    await tester.tap(find.text('Build'));
    await tester.pumpAndSettle();

    // Trigger GC
    await tester.binding.convertFlutterSurfaceToImage();
    await tester.binding.setSurfaceSemantics(true);
    await tester.binding.setSemantics(true);
    await tester.binding.reportReadinessForFrame();
    await tester.pumpAndSettle();

    // Verify memory usage
    expect(await tester.binding.getHeapSize(), lessThan(100000000));
  });
}
