import 'package:game/utils/dispose_helpers.dart';
import 'package:flutter/material.dart';

class RebecaAnimations {
  AnimationController? _animationController;_animationController = AnimationController? _animationController;();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }

  void initAnimation(TickerProvider tickerProvider) {
    _animationController = AnimationController(_animationController = AnimationController(();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
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
