import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('performance test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Implement performance metrics collection using Flutter Driver or Integration Test
    // For example, you can use tester.binding.framePolicy to control frame rendering
    // and measure the time it takes to render frames.

    // Example metric: frame rate
    final stopwatch = Stopwatch()..start();
    await tester.pumpAndSettle();
    final elapsed = stopwatch.elapsed;
    print('Frame rendering time: $elapsed');

    // You can also use IntegrationTestWidgetsFlutterBinding.instance to access
    // performance metrics such as frame rate, memory usage, etc.
  });
}
