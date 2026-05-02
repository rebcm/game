import 'package:flutter/material.dart';

class AnimacaoBlocos with ChangeNotifier {
  AnimationController? _animationController;

  void iniciarAnimacao() {
    _animationController?.forward();
  }

  void pararAnimacao() {
    _animationController?.reset();
  }
}
