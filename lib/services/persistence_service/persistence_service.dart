import 'package:flutter/material.dart';

class PersistenceService with ChangeNotifier {
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  void initialize() {
    _isInitialized = true;
    notifyListeners();
  }

  void reset() {
    _isInitialized = false;
    notifyListeners();
  }
}
