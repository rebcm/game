import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/controllers/animation_controller.dart';

void main() {
  group('Animação Integração Test', () {
    testWidgets('Deve responder corretamente a inputs de alta frequência',
        (tester) async {
      // Arrange
      final animationController = AnimationController();

      // Act
      await tester.pumpWidget(MyApp(animationController: animationController));
      await tester.tap(find.byType(GestureDetector)); // Simula input de alta frequência
      await tester.pumpAndSettle();

      // Assert
      expect(animationController.isAnimating, true);
    });
  });
}
