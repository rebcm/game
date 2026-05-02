import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'cleanup_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Cleanup Suite', () {
    testWidgets('cleanup', (tester) async {
      await CleanupHelper.cleanup();
    });
  });
}
