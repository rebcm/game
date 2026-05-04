import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/features/feedback_form/feedback_form.dart';

void main() {
  testWidgets('Feedback form submission test', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: FeedbackForm()));

    await tester.enterText(find.byType(TextFormField).at(0), '10 minutes');
    await tester.enterText(find.byType(TextFormField).at(1), 'Some confusion points');
    await tester.enterText(find.byType(TextFormField).at(2), 'Some missing steps');

    await tester.tap(find.text('Submit'));

    await tester.pump();

    expect(find.text('Form submitted successfully'), findsOneWidget);
  });
}
