import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Chunk transition benchmark', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Measure frame time during chunk transitions
    final stopwatch = Stopwatch()..start();
    for (int i = 0; i < 100; i++) {
      await tester.fling(find.byType(GridView), Offset(500, 0), 1000);
      await tester.pumpAndSettle(Duration(milliseconds: 50));
    }
    stopwatch.stop();

    // Log the results
    print('Chunk transition benchmark: ${stopwatch.elapsedMilliseconds} ms');
  });
}
