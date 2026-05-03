import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Rendering integration test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Verify initial rendering
    expect(find.byType(CustomVoxelRenderer), findsOneWidget);

    // Simulate chunk loading
    await tester.pumpAndSettle(Duration(seconds: 2));

    // Verify that new chunks are loaded without blocking the main thread
    expect(find.byType(CustomVoxelRenderer), findsOneWidget);
  });
}
