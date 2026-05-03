import 'package:flutter/material.dart';

class AudioService with ChangeNotifier {
  bool _isConnected = true;
  bool get isConnected => _isConnected;

  void onConnectionLost() {
    _isConnected = false;
    notifyListeners();
  }

  void onConnectionRecovered() {
    _isConnected = true;
    notifyListeners();
  }
}
