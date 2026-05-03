import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:game/utils/performance_testing/memory_leak_detector.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final memoryLeakDetector = MemoryLeakDetector();

  testWidgets('Stress Test: Open and close game screen repeatedly with memory check', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    for (int i = 0; i < 10; i++) {
      await tester.tap(find.text('Start Game'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Exit Game'));
      await tester.pumpAndSettle();
      await memoryLeakDetector.detectMemoryLeak();
    }
  });
}
