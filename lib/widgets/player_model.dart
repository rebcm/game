import 'package:game/utils/dispose_helpers.dart';
import 'package:flutter/material.dart';
import 'package:game/animations/player_animation_controller.dart';

class PlayerModel extends StatefulWidget {
  @override
  _PlayerModelState createState() => _PlayerModelState();
}

class _PlayerModelState extends State<PlayerModel> with TickerProviderStateMixin {
  late final PlayerAnimationController _animationController;_animationController = AnimationController _animationController;();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }

  @override
  void initState() {
    super.initState();
    _animationController = PlayerAnimationController(_animationController = AnimationController(();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
      AnimationController(_animationController = AnimationController(();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onPlayerMovement(bool isWalking) {
    if (isWalking) {
      _animationController.transitionToWalking();
    } else {
      _animationController.transitionToIdle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController.idleToWalking,
      builder: (context, child) {
        return Stack(
          children: [
            FadeTransition(
              opacity: Tween<double>(begin: 1, end: 0).animate(_animationController.idleToWalking),
              child: // idle animation,
            ),
            FadeTransition(
              opacity: _animationController.idleToWalking,
              child: // walking animation,
            ),
          ],
        );
      },
    );
  }
}
