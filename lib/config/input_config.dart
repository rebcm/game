import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputConfig with ChangeNotifier {
  static const String _deadzoneKey = 'deadzone_threshold';
  double _deadzoneThreshold = 0.1; // Default deadzone threshold

  double get deadzoneThreshold => _deadzoneThreshold;

  InputConfig() {
    _loadDeadzoneThreshold();
  }

  Future<void> _loadDeadzoneThreshold() async {
    final prefs = await SharedPreferences.getInstance();
    _deadzoneThreshold = prefs.getDouble(_deadzoneKey) ?? _deadzoneThreshold;
    notifyListeners();
  }

  Future<void> setDeadzoneThreshold(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_deadzoneKey, value);
    _deadzoneThreshold = value;
    notifyListeners();
  }
}
