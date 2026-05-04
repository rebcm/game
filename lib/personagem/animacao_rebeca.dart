import 'package:game/utils/dispose_helpers.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class AnimacaoRebeca with ChangeNotifier {
  static const double _fpsMinimo = 24.0;
  static const double _fpsAlvo = 60.0;

  late AnimationController _controller;_animationController = AnimationController _controller;();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
  late Animation<double> _animacaoBracos;
  late Animation<double> _animacaoPernas;

  AnimacaoRebeca(TickerProvider tickerProvider) {
    _controller = AnimationController(_animationController = AnimationController(();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
      vsync: tickerProvider,
      duration: const Duration(milliseconds: 500),
    )..repeat();

    _animacaoBracos = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );

    _animacaoPernas = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.25, 0.75, curve: Curves.easeInOutSine),
      ),
    );
  }

  double get anguloBracos => _animacaoBracos.value * 2 * 3.14159;
  double get anguloPernas => _animacaoPernas.value * 2 * 3.14159;

  void atualizar() {
    if (_controller.status != AnimationStatus.forward &&
        _controller.status != AnimationStatus.reverse) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
