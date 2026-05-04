import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App Startup Performance Test', (tester) async {
    final stopwatch = Stopwatch()..start();
    app.main();
    await tester.pumpAndSettle();
    stopwatch.stop();
    final elapsedTime = stopwatch.elapsed.inMilliseconds;
    expect(elapsedTime, lessThan(5000)); // 5 seconds
  });
}
