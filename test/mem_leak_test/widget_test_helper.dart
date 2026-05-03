import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class WidgetTestHelper {
  static Future<void> pumpAndSettle(WidgetTester tester) async {
    await tester.pumpAndSettle();
  }

  static Finder findByType<T>(WidgetTester tester) {
    return find.byType(T);
  }
}
