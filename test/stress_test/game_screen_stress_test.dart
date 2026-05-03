import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';

void main() {
  testWidgets('Game screen stress test', (tester) async {
    await tester.pumpWidget(MyApp());

    for (var i = 0; i < 10; i++) {
      await tester.tap(find.text('Play'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Back'));
      await tester.pumpAndSettle();
    }
  });
}
