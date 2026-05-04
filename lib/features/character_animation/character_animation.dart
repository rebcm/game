import 'package:game/utils/dispose_helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/character_animation/providers/character_animation_provider.dart';

class CharacterAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CharacterAnimationProvider>(
      builder: (context, provider, child) {
        return AnimatedBuilder(
          animation: AnimationController(_animationController = AnimationController(();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
            vsync: this,
            duration: Duration(milliseconds: 16), // 60 FPS
          ),
          builder: (context, child) {
            // Animation logic here
            return Container(); // placeholder
          },
        );
      },
    );
  }
}
