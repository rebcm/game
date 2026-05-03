import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyMappingService with ChangeNotifier {
  static const String _keyMappingKey = 'key_mapping';

  Map<String, String> _keyMapping = {};

  Map<String, String> get keyMapping => _keyMapping;

  Future<void> loadKeyMapping() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyMappingKey);
    if (jsonString != null) {
      _keyMapping = Map<String, String>.from(json.decode(jsonString));
      notifyListeners();
    }
  }

  Future<void> saveKeyMapping(Map<String, String> keyMapping) async {
    final prefs = await SharedPreferences.getInstance();
    _keyMapping = keyMapping;
    await prefs.setString(_keyMappingKey, json.encode(keyMapping));
    notifyListeners();
  }

  Future<void> resetKeyMapping() async {
    final prefs = await SharedPreferences.getInstance();
    _keyMapping = {};
    await prefs.remove(_keyMappingKey);
    notifyListeners();
  }
}
