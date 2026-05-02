import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/movement_animation/controller/movement_animation_controller.dart';
import 'package:passdriver/features/movement_animation/view/movement_animation.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Animação de andar é disparada corretamente', (tester) async {
    final animationController = AnimationController(vsync: tester);
    final movementAnimationController = MovementAnimationController(animationController);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => movementAnimationController),
        ],
        child: MaterialApp(
          home: MovementAnimation(),
        ),
      ),
    );

    movementAnimationController.updateSpeed(1.0);
    movementAnimationController.animate();

    await tester.pump();

    expect(animationController.status, AnimationStatus.forward);
  });

  testWidgets('Velocidade da animação é proporcional à velocidade de deslocamento', (tester) async {
    final animationController = AnimationController(vsync: tester);
    final movementAnimationController = MovementAnimationController(animationController);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => movementAnimationController),
        ],
        child: MaterialApp(
          home: MovementAnimation(),
        ),
      ),
    );

    movementAnimationController.updateSpeed(2.0);
    expect(animationController.duration, Duration(milliseconds: 500));

    movementAnimationController.updateSpeed(0.5);
    expect(animationController.duration, Duration(milliseconds: 1000));
  });
}
