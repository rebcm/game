import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Stress Test for Retention of Closures and Streams', () {
    testWidgets('Validate retention after unloading chunks', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      // Simulate chunk loading and unloading
      await tester.tap(find.text('Load Chunk'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Unload Chunk'));
      await tester.pumpAndSettle();

      // Validate memory retention
      expect(find.text('Memory Leak Detected'), findsNothing);
    });

    testWidgets('Validate stream listeners after unloading chunks', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      // Simulate chunk loading and unloading with stream listeners
      await tester.tap(find.text('Load Chunk with Stream'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Unload Chunk with Stream'));
      await tester.pumpAndSettle();

      // Validate stream listener retention
      expect(find.text('Stream Listener Leak Detected'), findsNothing);
    });
  });
}
