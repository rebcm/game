import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('layout test for different resolutions', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    const resolutions = [
      Size(320, 480),
      Size(375, 667),
      Size(414, 896),
    ];

    for (var resolution in resolutions) {
      await tester.binding.setSurfaceSize(resolution);
      await tester.pumpAndSettle();

      // Add your layout validation logic here
      expect(find.text('Rebeca'), findsOneWidget);
    }
  });
}
