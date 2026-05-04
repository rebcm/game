import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('memory snapshot test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Capture heap snapshot before unloading chunks
    final beforeUnloadSnapshot = await IntegrationTestWidgetsFlutterBinding.instance.debugDumpApp();
    print('Heap snapshot before unloading chunks: $beforeUnloadSnapshot');

    // Simulate unloading chunks
    // await tester.tap(find.byTooltip('Unload Chunks'));
    // await tester.pumpAndSettle();

    // Capture heap snapshot after unloading chunks
    // final afterUnloadSnapshot = await IntegrationTestWidgetsFlutterBinding.instance.debugDumpApp();
    // print('Heap snapshot after unloading chunks: $afterUnloadSnapshot');

    // Compare the snapshots
    // expect(afterUnloadSnapshot, isNot(beforeUnloadSnapshot));
  });
}
