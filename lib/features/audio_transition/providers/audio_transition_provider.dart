import 'package:flutter/material.dart';

class AudioTransitionProvider with ChangeNotifier {
  double _beginVolume = 1.0;
  double _endVolume = 0.0;
  int _transitionDuration = 5000;
  double _currentVolume = 1.0;
  Widget _currentAudioWidget;

  double get beginVolume => _beginVolume;
  double get endVolume => _endVolume;
  int get transitionDuration => _transitionDuration;
  double get currentVolume => _currentVolume;
  Widget get currentAudioWidget => _currentAudioWidget;

  void setBeginVolume(double volume) {
    _beginVolume = volume;
    notifyListeners();
  }

  void setEndVolume(double volume) {
    _endVolume = volume;
    notifyListeners();
  }

  void setTransitionDuration(int duration) {
    _transitionDuration = duration;
    notifyListeners();
  }

  void setCurrentVolume(double volume) {
    _currentVolume = volume;
    notifyListeners();
  }

  void setCurrentAudioWidget(Widget widget) {
    _currentAudioWidget = widget;
    notifyListeners();
  }
}
