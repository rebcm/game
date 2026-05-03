import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart';

void main() {
  testWidgets('should play multiple sounds simultaneously without crashing the app', (tester) async {
    await tester.pumpWidget(const MyApp());
    for (var i = 0; i < 10; i++) {
      await tester.tap(find.text('Play Sound'));
      await tester.pump();
    }
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Playing'), findsOneWidget);
  });
}
