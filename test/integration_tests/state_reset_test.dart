import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'test_utils.dart' as utils;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('State Reset Test', () {
    testWidgets('reset state before each test', (tester) async {
      await utils.main();
      await tester.pumpAndSettle();
    });
  });
}
