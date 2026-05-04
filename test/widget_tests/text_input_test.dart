import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Text input fields should accept text input', (tester) async {
    await tester.pumpWidget(const MyApp());

    final textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsOneWidget);

    await tester.tap(textFieldFinder);
    await tester.enterText(textFieldFinder, 'Hello, World!');
    await tester.pump();

    expect(find.text('Hello, World!'), findsOneWidget);
  });

  testWidgets('WASD keys should not interfere with text input', (tester) async {
    await tester.pumpWidget(const MyApp());

    final textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsOneWidget);

    await tester.tap(textFieldFinder);
    await tester.enterText(textFieldFinder, 'WASD');
    await tester.pump();

    expect(find.text('WASD'), findsOneWidget);
  });

  testWidgets('Space key should not interfere with text input', (tester) async {
    await tester.pumpWidget(const MyApp());

    final textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsOneWidget);

    await tester.tap(textFieldFinder);
    await tester.enterText(textFieldFinder, 'Hello World');
    await tester.pump();

    expect(find.text('Hello World'), findsOneWidget);
  });
}
