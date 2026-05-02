import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Test Utils', () {
    testWidgets('clear persisted data', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    });
  });
}
