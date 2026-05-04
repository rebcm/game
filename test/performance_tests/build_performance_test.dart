import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Build Performance Test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final stopwatch = Stopwatch()..start();
    await tester.pumpAndSettle();
    stopwatch.stop();

    final buildTime = stopwatch.elapsedMilliseconds;
    expect(buildTime, lessThan(3000)); // 3 seconds
    print('Build time: $buildTime ms');
  });
}
