import 'package:flutter/material.dart';

class RideHailingProvider with ChangeNotifier {
  // provider logic here

  void updateMap() {
    notifyListeners();
  }
}
