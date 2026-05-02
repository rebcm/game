import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:construcao_criativa/main.dart' as app;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('validate persistence on crash', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    // Simulate volume change and verify data is written
    await tester.tap(find.text('Grama'));
    await tester.pumpAndSettle();

    // Verify data is persisted
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getInt('selectedBlock'), TipoBloco.grama.index);

    // Simulate app crash
    exit(0);
  });
}
