import 'package:flutter/material.dart';

class AudioEngine with ChangeNotifier {
  bool _isInitialized = false;

  Future<void> init() async {
    // Simulating audio engine initialization
    await Future.delayed(const Duration(milliseconds: 100));
    _isInitialized = true;
    notifyListeners();
  }

  bool get isInitialized => _isInitialized;
}
