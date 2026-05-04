import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/animation_service.dart';
import 'package:game/models/player_animation.dart';
import 'package:flutter/animation.dart';

void main() {
  test('AnimationService transitions correctly', () {
    final animationController = AnimationController(vsync: TestVSync());
    final playerAnimation = PlayerAnimation(animationController: animationController);
    final animationService = AnimationService(playerAnimation);

    animationService.transitionTo(PlayerAnimationState.walking);
    expect(animationController.status, AnimationStatus.forward);

    animationService.transitionTo(PlayerAnimationState.idle);
    expect(animationController.status, AnimationStatus.forward);
  });
}
