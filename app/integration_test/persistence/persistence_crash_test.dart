import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:construcao_criativa/features/persistence/persistence_manager.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('validate persistence on crash', (tester) async {
    await tester.pumpWidget(MyApp());

    // Simulate world change
    await tester.tap(find.text('New Block'));
    await tester.pumpAndSettle();

    // Force crash
    await tester.binding.defaultBinaryMessenger.handlePlatformMessage(
      'flutter/platform',
      StandardMethodCodec().encodeMethodCall(MethodCall('Crash')),
      (ByteData? data) {},
    );

    // Restart app
    await tester.restartApp();

    // Validate world state
    expect(find.text('New Block'), findsOneWidget);
  });
}
