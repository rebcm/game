import 'package:flutter/material.dart';

class RebecaAnimations {
  AnimationController? _animationController;

  void initAnimation(TickerProvider tickerProvider) {
    _animationController = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(milliseconds: 500),
    );
  }

  Animation<double> getAnimation() {
    return _animationController!.view;
  }

  void dispose() {
    _animationController?.dispose();
  }
}
