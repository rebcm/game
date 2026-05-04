import 'package:flutter_test/flutter_test.dart';
import 'package:game/animations/player_animation_controller.dart';

void main() {
  testWidgets('PlayerAnimationController transitions correctly', (tester) async {
    final animationController = AnimationController(
      vsync: tester,
      duration: const Duration(milliseconds: 300),
    );
    final playerAnimationController = PlayerAnimationController(animationController);

    playerAnimationController.transitionToWalking();
    await tester.pumpAndSettle();

    expect(animationController.value, 1);

    playerAnimationController.transitionToIdle();
    await tester.pumpAndSettle();

    expect(animationController.value, 0);
  });
}
