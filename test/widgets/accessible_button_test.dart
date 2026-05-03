import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/widgets/accessible_button.dart';

void main() {
  testWidgets('AccessibleButton is focusable and actionable', (tester) async {
    bool pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AccessibleButton(
            onPressed: () => pressed = true,
            label: 'Test Button',
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final buttonFinder = find.byType(ElevatedButton);
    expect(buttonFinder, findsOneWidget);

    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pumpAndSettle();

    expect(FocusManager.instance.primaryFocus?.hasFocus, isTrue);

    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();

    expect(pressed, isTrue);
  });
}
