import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('e2e test', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Add test logic here
  });
}

class RetryTestDriver {
  static const int maxRetryCount = 3;
  int _retryCount = 0;

  Future<void> runTest(Future<void> Function() testFunction) async {
    try {
      await testFunction();
    } catch (e) {
      if (_retryCount < maxRetryCount) {
        _retryCount++;
        await runTest(testFunction);
      } else {
        rethrow;
      }
    }
  }
}
