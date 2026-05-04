import 'package:game/utils/dispose_helpers.dart';
import 'package:flutter/material.dart';

void disposeaddAnimationController(AnimationController(AnimationController? controller)) {_animationController = AnimationController(AnimationController(AnimationController? controller)) {();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
  controller?.dispose();
}
