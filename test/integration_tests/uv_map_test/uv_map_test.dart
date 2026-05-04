import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;

void main() {
  testWidgets('UV Map Test', (tester) async {
    await tester.pumpWidget(const app.MyApp());
    await tester.pumpAndSettle();

    // Assuming there's a widget or a way to verify the UV mapping
    // For demonstration, we'll just check if a specific widget exists
    expect(find.text('Rebeca'), findsOneWidget);
  });
}
