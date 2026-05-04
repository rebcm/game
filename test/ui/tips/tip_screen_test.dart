import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/ui/tips/tip_screen.dart';

void main() {
  testWidgets('TipScreen displays tip correctly', (WidgetTester tester) async {
    const tip = 'This is a test tip.';
    await tester.pumpWidget(
      MaterialApp(
        home: TipScreen(tip: tip),
      ),
    );

    expect(find.text(tip), findsOneWidget);
  });
}
