import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeadzoneConfig with ChangeNotifier {
  static const String _deadzoneThresholdKey = 'deadzoneThreshold';
  double _deadzoneThreshold = 0.1; // Default deadzone threshold

  double get deadzoneThreshold => _deadzoneThreshold;

  Future<void> loadDeadzoneThreshold() async {
    final prefs = await SharedPreferences.getInstance();
    _deadzoneThreshold = prefs.getDouble(_deadzoneThresholdKey) ?? 0.1;
    notifyListeners();
  }

  Future<void> setDeadzoneThreshold(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_deadzoneThresholdKey, value);
    _deadzoneThreshold = value;
    notifyListeners();
  }
}
