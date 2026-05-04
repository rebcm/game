import 'package:flutter/material.dart';

class PlayerState with ChangeNotifier {
  String _currentMusic = '';

  String get currentMusic => _currentMusic;

  void updateCurrentMusic(String music) {
    _currentMusic = music;
    notifyListeners();
  }
}
