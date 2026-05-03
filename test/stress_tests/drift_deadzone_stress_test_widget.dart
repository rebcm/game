import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Drift Deadzone Stress Test Widget', (tester) async {
    await tester.pumpWidget(MyApp());

    final joystick = find.byTooltip('Joystick');
    await tester.tap(joystick);
    await tester.pumpAndSettle();

    final deadzoneIndicator = find.byType('DeadzoneIndicator');
    expect(deadzoneIndicator, findsOneWidget);
  });
}
