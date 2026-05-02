import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('cleanup test', (tester) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  });
}

class CleanupHelper {
  static Future<void> cleanup() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
