import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Memory baseline test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Navigate to the game screen
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();

    // Measure memory usage
    final memoryUsage = await tester.binding.debugMemoryInfo.currentRSS;
    print('Memory usage: $memoryUsage');

    // Save memory usage to a file
    final file = File('memory_baseline_results.json');
    await file.writeAsString('{"memory_usage": $memoryUsage}');
  });
}
