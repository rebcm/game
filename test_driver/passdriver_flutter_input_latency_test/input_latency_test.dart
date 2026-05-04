import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('input latency test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simulate input and measure latency
    final stopwatch = Stopwatch()..start();
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    final latency = stopwatch.elapsed.inMilliseconds;

    expect(latency, lessThan(100)); // 100ms latency threshold
  });
}
