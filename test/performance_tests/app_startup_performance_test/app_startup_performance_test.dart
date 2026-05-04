import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App Startup Performance Test', (tester) async {
    final stopwatch = Stopwatch()..start();
    await app.main();
    await tester.pumpAndSettle();
    stopwatch.stop();
    print('Startup time: ${stopwatch.elapsed.inMilliseconds} ms');
    expect(stopwatch.elapsed.inMilliseconds, lessThan(5000));
  });
}
