import 'package:flutter/material.dart';

class AudioTransition with ChangeNotifier {
  double _volume = 1.0;

  double get volume => _volume;

  void interpolateVolume(double targetVolume, Duration duration) {
    final AnimationController controller = AnimationController(
      vsync: Navigator.of(navigatorKey.currentContext!),
      duration: duration,
    );

    final Animation<double> animation = Tween<double>(
      begin: _volume,
      end: targetVolume,
    ).animate(controller);

    animation.addListener(() {
      _volume = animation.value;
      notifyListeners();
    });

    controller.forward().whenComplete(() => controller.dispose());
  }
}
