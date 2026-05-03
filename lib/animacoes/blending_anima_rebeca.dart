import 'package:flame/animation.dart' as flame_animation;
import 'package:flame/components.dart';
import 'package:flutter/animation.dart';
import 'package:rebcm/componentes/personagem_rebeca.dart';

class BlendingAnimaRebeca extends PositionComponent with HasAnimation {
  final PersonagemRebeca _rebeca;

  BlendingAnimaRebeca(this._rebeca) : super(priority: 1);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final idleAnimation = await flame_animation.Animation.load(
      'idle.png',
      SpriteSheetData(
        columns: 8,
        rows: 1,
        image: await images.load('animacoes/rebeca/idle.png'),
      ),
      stepTime: 0.1,
    );

    final walkingAnimation = await flame_animation.Animation.load(
      'walking.png',
      SpriteSheetData(
        columns: 8,
        rows: 1,
        image: await images.load('animacoes/rebeca/walking.png'),
      ),
      stepTime: 0.1,
    );

    animation = flame_animation.AnimationTicker(idleAnimation);
    _rebeca.stateNotifier.addListener((state) {
      if (state.isWalking && animation?.currentIndex != walkingAnimation.frames.first.index) {
        animation = flame_animation.AnimationTicker(walkingAnimation);
      } else if (!state.isWalking && animation?.currentIndex != idleAnimation.frames.first.index) {
        animation = flame_animation.AnimationTicker(idleAnimation);
      }
    });
  }
}
