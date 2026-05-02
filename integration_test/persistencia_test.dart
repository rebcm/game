import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'dart:io';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Simular crash após alteração de volume', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simular alteração de volume
    await tester.tap(find.text('Bloco 1'));
    await tester.pumpAndSettle();

    // Simular crash
    exit(0);
  });
}
