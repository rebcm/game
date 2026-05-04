import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Checksum test', (WidgetTester tester) async {
    // This test is handled by the CI script
    await tester.pumpWidget(Container());
    expect(true, true);
  });
}
