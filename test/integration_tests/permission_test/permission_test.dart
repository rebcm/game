import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:permission_handler/permission_handler.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test permanent denial of permission', (tester) async {
    await app.main();
    await tester.pumpAndSettle();
    // Simulate permanent denial
    await Permission.microphone.request();
    await tester.pumpAndSettle();
    // Verify app behavior
    expect(find.text('Permission denied'), findsOneWidget);
  });

  testWidgets('Test device without microphone hardware', (tester) async {
    await app.main();
    await tester.pumpAndSettle();
    // Simulate device without microphone
    // Verify app behavior
    expect(find.text('No microphone available'), findsOneWidget);
  });

  testWidgets('Test permission revoked while app is open', (tester) async {
    await app.main();
    await tester.pumpAndSettle();
    // Simulate permission revocation
    await Permission.microphone.request();
    await tester.pumpAndSettle();
    // Verify app behavior
    expect(find.text('Permission revoked'), findsOneWidget);
  });
}
