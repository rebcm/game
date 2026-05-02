import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/animation_test/widgets/animation_test_widget.dart';

void main() {
  testWidgets('Animation test', (tester) async {
    await tester.pumpWidget(MaterialApp(home: AnimationTestWidget()));
    await tester.tap(find.text('Other State'));
    await tester.pumpAndSettle();
    expect(find.byType(AnimationTest), findsOneWidget);
    await tester.tap(find.text('Idle'));
    await tester.pumpAndSettle();
    expect(find.byType(AnimationTest), findsOneWidget);
  });
}
