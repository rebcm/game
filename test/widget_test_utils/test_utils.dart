import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TestUtils {
  static Future<void> pumpAndSettleWithDelay(WidgetTester tester, {Duration delay = const Duration(milliseconds: 500)}) async {
    await tester.pump(delay);
    await tester.pumpAndSettle();
  }
}
