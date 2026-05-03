import 'package:flutter/foundation.dart';

class VolumeGuard with ChangeNotifier {
  bool _isUpdating = false;

  bool get isUpdating => _isUpdating;

  void updateVolume(double volume) {
    if (_isUpdating) return;
    _isUpdating = true;
    notifyListeners();
    // Logic to update volume
    _isUpdating = false;
    notifyListeners();
  }
}
