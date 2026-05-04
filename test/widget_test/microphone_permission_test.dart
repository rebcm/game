import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('should show error when microphone permission is denied', (tester) async {
    await tester.pumpWidget(MyApp());
    // Simulate permission denial
    await tester.pumpAndSettle();
    expect(find.text('Microphone permission denied'), findsOneWidget);
  });
}
