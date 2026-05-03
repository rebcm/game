import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:integration_test/integration_test.dart';
import 'test_config.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  configureTest();

  testWidgets('integration test', (tester) async {
    await app.main();
    await tester.pumpAndSettle();
  });
}
