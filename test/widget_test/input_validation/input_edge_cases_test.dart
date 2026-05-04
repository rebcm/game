import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Simultaneous keyboard and touch input test', (tester) async {
    await tester.pumpWidget(MyApp());

    // Simulate touch input
    await tester.tap(find.byType(GestureDetector));
    await tester.pump();

    // Simulate keyboard input
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    await tester.pump();

    // Verify the state after simultaneous input
    expect(find.text('Expected Output'), findsOneWidget);
  });
}
