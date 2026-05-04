import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Memory test with GC forcing', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simulate some actions
    await tester.tap(find.text('Some Button'));
    await tester.pumpAndSettle();

    // Force GC
    await IntegrationTestWidgetsFlutterBinding.instance?.performGC();

    // Validate memory usage
    expect(await IntegrationTestWidgetsFlutterBinding.instance?.isMemoryLeak(), false);
  });
}
