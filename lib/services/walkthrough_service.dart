import 'package:flutter/material.dart';

class WalkthroughService with ChangeNotifier {
  /// Current step of the walkthrough
  int _currentStep = 0;

  int get currentStep => _currentStep;

  /// Move to the next step in the walkthrough
  void nextStep() {
    if (_currentStep < 2) { // Assuming 2 steps for now
      _currentStep++;
      notifyListeners();
    }
  }

  /// Move to the previous step in the walkthrough
  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  /// Reset the walkthrough to the first step
  void reset() {
    _currentStep = 0;
    notifyListeners();
  }
}
