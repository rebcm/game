import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Text overflow test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final textFinder = find.text('Very long text that should not overflow');
    expect(textFinder, findsOneWidget);

    final overflowFinder = find.byType(OverflowBar);
    expect(overflowFinder, findsNothing);
  });
}
