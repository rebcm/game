import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/widgets/keyboard_navigable_button.dart';

void main() {
  testWidgets('Test Keyboard Navigability', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              KeyboardNavigableButton(
                onPressed: () {},
                child: Text('Button 1'),
              ),
              KeyboardNavigableButton(
                onPressed: () {},
                child: Text('Button 2'),
              ),
            ],
          ),
        ),
      ),
    );

    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();

    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pump();

    expect(find.text('Button 1'), findsOneWidget);
  });
}
