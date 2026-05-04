import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Text integration test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final textFinder = find.text('Detailed description');
    expect(textFinder, findsOneWidget);

    final textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsNothing);
  });
}
