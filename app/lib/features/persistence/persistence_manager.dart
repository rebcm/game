import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistenceManager with ChangeNotifier {
  static const String _key = 'game_data';

  Future<void> saveData(String data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, data);
  }

  Future<String?> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }
}
