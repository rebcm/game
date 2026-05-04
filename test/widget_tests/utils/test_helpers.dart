import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void tapWidget(WidgetTester tester, Finder finder) async {
  await tester.tap(finder);
  await tester.pump();
}

void enterTextInWidget(WidgetTester tester, Finder finder, String text) async {
  await tester.enterText(finder, text);
  await tester.pump();
}
