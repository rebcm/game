import 'package:shared_preferences/shared_preferences.dart';

class TestUtils {
  static Future<void> cleanupTestData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('test_key');
  }
}
