import 'package:flutter/animation.dart';

class RebecaAnimation with ChangeNotifier {
  late AnimationController _animationController;
  late Animation<double> _armsAnimation;
  late Animation<double> _legsAnimation;

  RebecaAnimation(TickerProvider tickerProvider) {
    _animationController = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(milliseconds: 500),
    )..repeat();

    _armsAnimation = Tween<double>(begin: -0.5, end: 0.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _legsAnimation = Tween<double>(begin: -0.5, end: 0.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  Animation<double> get armsAnimation => _armsAnimation;
  Animation<double> get legsAnimation => _legsAnimation;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
