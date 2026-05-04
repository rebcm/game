import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Build Performance Test', (tester) async {
    await app.main();
    await tester.pumpAndSettle();
    final stopwatch = Stopwatch()..start();
    await tester.pumpAndSettle();
    stopwatch.stop();
    print('Build time: ${stopwatch.elapsed.inMilliseconds} ms');
    expect(stopwatch.elapsed.inMilliseconds, lessThan(3000));
  });
}
