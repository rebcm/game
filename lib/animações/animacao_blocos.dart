import 'package:game/utils/dispose_helpers.dart';
import 'package:flutter/material.dart';

class AnimacaoBlocos with ChangeNotifier {
  AnimationController? _animationController;_animationController = AnimationController? _animationController;();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }

  void iniciarAnimacao() {
    _animationController?.forward();
  }

  void pararAnimacao() {
    _animationController?.reset();
  }
}
