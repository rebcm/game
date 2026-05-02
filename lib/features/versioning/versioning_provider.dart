import 'package:flutter/material.dart';

class VersioningProvider with ChangeNotifier {
  String _version = '';

  String get version => _version;

  void updateVersion(String version) {
    _version = version;
    notifyListeners();
  }
}
