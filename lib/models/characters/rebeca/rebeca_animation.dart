import 'package:game/utils/dispose_helpers.dart';
import 'package:flutter/animation.dart';

class RebecaAnimation with ChangeNotifier {
  late AnimationController _animationController;_animationController = AnimationController _animationController;();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
  late Animation<double> _armsAnimation;
  late Animation<double> _legsAnimation;

  RebecaAnimation(TickerProvider tickerProvider) {
    _animationController = AnimationController(_animationController = AnimationController(();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
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
