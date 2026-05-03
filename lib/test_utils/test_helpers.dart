import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Finder findText(String text) => find.text(text);

void tap(WidgetTester tester, Finder finder) async {
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void expectWidget(WidgetTester tester, Finder finder) {
  expect(finder, findsOneWidget);
}
