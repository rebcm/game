import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import './utils/test_utils.dart' as test_utils;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('State Reset Test', () {
    testWidgets('reset state', (tester) async {
      await test_utils.main();
      await tester.pumpAndSettle();
    });
  });
}
