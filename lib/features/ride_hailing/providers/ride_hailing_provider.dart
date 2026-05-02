import 'package:flutter/material.dart';

class RideHailingProvider with ChangeNotifier {
  late AnimationController _animationController;
  late Animation<double> _animation;

  Animation<double> get animation => _animation;

  RideHailingProvider({required TickerProvider vsync}) {
    _animationController = AnimationController(
      vsync: vsync,
      duration: Duration(seconds: 2),
    )..repeat();
    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
