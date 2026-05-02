import 'package:flutter/material.dart';

enum RideStatus { walking, driving, stopped }

class RideState with ChangeNotifier {
  RideStatus _status = RideStatus.walking;

  RideStatus get status => _status;

  void updateStatus(RideStatus status) {
    _status = status;
    notifyListeners();
  }

  void stopRide() {
    updateStatus(RideStatus.stopped);
  }
}
