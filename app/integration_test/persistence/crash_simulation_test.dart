import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:construcao_criativa/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('simulate app crash after volume change', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    // Simulate volume change
    await tester.tap(find.text('Grama'));
    await tester.pumpAndSettle();

    // Simulate crash
    Process.runSync('kill', ['-9', '${Process.pid}']);
  });
}
