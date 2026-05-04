import 'package:flutter/foundation.dart';

class PackageTracker with ChangeNotifier {
  final List<int> _packageIds = [];
  bool _isTracking = false;

  List<int> get packageIds => _packageIds;
  bool get isTracking => _isTracking;

  void startTracking() {
    _packageIds.clear();
    _isTracking = true;
    notifyListeners();
  }

  void stopTracking() {
    _isTracking = false;
    notifyListeners();
  }

  void addPackageId(int id) {
    if (_isTracking) {
      _packageIds.add(id);
      notifyListeners();
    }
  }

  List<int> getTrackedPackageIds() {
    return List.from(_packageIds);
  }
}
