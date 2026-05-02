import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class PersistenceManager {
  static Future<void> saveState(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> loadState(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
