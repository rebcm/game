import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/widgets/animation_controller.dart';

void main() {
  testWidgets('Animation controller test', (tester) async {
    await tester.pumpWidget(MyAnimationController());
    final animationController = find.byValueKey('animationController');
    expect(animationController, findsOneWidget);
    await tester.tap(find.text('Tap me'));
    await tester.pump();
    expect(find.text('Animation running'), findsOneWidget);
  });
}
