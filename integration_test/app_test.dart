import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('end-to-end test', (tester) async {
    app.main(staging: true);
    await tester.pumpAndSettle();

    // Implement your test logic here
    await Future.delayed(Duration(seconds: 10));
  });
}
