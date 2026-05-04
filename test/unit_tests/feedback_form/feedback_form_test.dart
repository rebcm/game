import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/features/feedback_form/feedback_form.dart';

void main() {
  testWidgets('Feedback form displays correctly', (tester) async {
    await tester.pumpWidget(MaterialApp(home: FeedbackForm()));
    expect(find.text('Onboarding Feedback'), findsOneWidget);
    expect(find.text('Setup Time (minutes)'), findsOneWidget);
    expect(find.text('Points of Confusion'), findsOneWidget);
    expect(find.text('Missing Steps'), findsOneWidget);
    expect(find.text('Submit'), findsOneWidget);
  });

  testWidgets('Feedback form validation works', (tester) async {
    await tester.pumpWidget(MaterialApp(home: FeedbackForm()));
    await tester.tap(find.text('Submit'));
    await tester.pump();
    expect(find.text('Please enter setup time'), findsOneWidget);
    expect(find.text('Please enter points of confusion'), findsOneWidget);
    expect(find.text('Please enter missing steps'), findsOneWidget);
  });
}
