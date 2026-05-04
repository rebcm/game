import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TestHelpers {
  static Future<void> pumpAndSettleWithTimeout(WidgetTester tester, {Duration timeout = const Duration(seconds: 10)}) async {
    await tester.pumpAndSettle(timeout);
  }
}
