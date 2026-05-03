import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Testa integração com configurações de fonte extra grande', (tester) async {
    await tester.pumpWidget(MyApp());

    // Simula as configurações de acessibilidade com texto extra grande
    await tester.binding.window.textScaleFactorTestOverride = 2.5;

    await tester.pumpAndSettle();

    // Verifica se a interface permanece acessível
    expect(find.text('Rebeca'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
