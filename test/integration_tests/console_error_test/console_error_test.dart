import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('console error test', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    await tester.binding.watchPerformance(() async {
      await Future.delayed(Duration(seconds: 2));
    }, reportProgress: true);
    final binding = tester.binding as IntegrationTestWidgetsFlutterBinding;
    final errors = binding.takeFlutterErrorLogs();
    expect(errors, isEmpty);
  });
}
