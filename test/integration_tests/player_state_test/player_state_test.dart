import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:game/services/audio_service/audio_service.dart';
import 'package:provider/provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('validate player state integration', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Verify initial state
    expect(find.text('Current Music'), findsOneWidget);

    // Simulate shuffle/loop button press
    await tester.tap(find.byIcon(Icons.shuffle));
    await tester.pumpAndSettle();

    // Verify UI update after shuffle/loop
    expect(find.text('Current Music'), findsOneWidget);
  });
}
