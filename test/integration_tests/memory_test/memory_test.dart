import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('force gc test', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // Trigger GC manually before measuring heap
    await tester.binding.debugForceGC();
  });
}
