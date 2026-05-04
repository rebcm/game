import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('memory snapshot test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Trigger chunk unloading
    await tester.tap(find.text('Unload Chunks'));
    await tester.pumpAndSettle();

    // Capture heap snapshot
    final snapshot = await IntegrationTestWidgetsFlutterBinding.instance.takeHeapSnapshot();

    // Save snapshot to file
    final file = File('test/integration_tests/memory_test/snapshot.json');
    await file.writeAsString(snapshot.toJson());

    expect(snapshot.objects, isNotEmpty);
  });
}
