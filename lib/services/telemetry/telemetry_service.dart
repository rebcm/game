import 'package:flutter/foundation.dart';

class TelemetryService {
  void trackHintDisplayed(String hintId) {
    // Implement tracking logic for hint displayed
    debugPrint('Hint displayed: $hintId');
  }

  void trackHintIgnored(String hintId) {
    // Implement tracking logic for hint ignored
    debugPrint('Hint ignored: $hintId');
  }
}
