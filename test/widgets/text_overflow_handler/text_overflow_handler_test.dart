import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/widgets/text_overflow_handler/text_overflow_handler.dart';

void main() {
  testWidgets('TextOverflowHandler should display text with ellipsis', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Row(
            children: [
              TextOverflowHandler(text: 'Very long text that should be truncated'),
            ],
          ),
        ),
      ),
    );

    final textFinder = find.text('Very long text that should be truncated');
    expect(textFinder, findsOneWidget);

    final textWidget = tester.widget<Text>(textFinder);
    expect(textWidget.overflow, TextOverflow.ellipsis);
  });
}
