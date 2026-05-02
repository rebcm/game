import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:rebcm/test_utils/cleanup_utils.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('test game flow', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Test logic here
  });

  tearDown(() async {
    await CleanupUtils.rollbackChanges();
  });
}
