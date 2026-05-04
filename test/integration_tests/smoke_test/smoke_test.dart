import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;

void main() {
  testWidgets('Smoke test for app initialization', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    expect(find.text('Rebeca'), findsOneWidget);
  });
}
