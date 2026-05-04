import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Verify error handling during app startup', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final errorHandler = tester.binding.defaultErrorHandler;
    expect(errorHandler.errors, isEmpty);
  });
}
