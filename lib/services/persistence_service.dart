import 'package:shared_preferences/shared_preferences.dart';

class PersistenceService {
  Future<void> saveMetadata(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getMetadata(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
