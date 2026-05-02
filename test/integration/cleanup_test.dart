import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('cleanup test', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    // Simulate test data
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('test_key', 'test_value');

    // Cleanup
    await prefs.remove('test_key');
    expect(await prefs.getString('test_key'), null);
  });
}
