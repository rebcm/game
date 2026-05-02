import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/widgets/animacao/optimized_animation.dart';

void main() {
  testWidgets('OptimizedAnimation should animate', (tester) async {
    final controller = AnimationController(vsync: tester);
    await tester.pumpWidget(OptimizedAnimation(controller: controller));
    controller.forward();
    await tester.pumpAndSettle();
    // Adicione expectativas específicas para a animação
  });
}
