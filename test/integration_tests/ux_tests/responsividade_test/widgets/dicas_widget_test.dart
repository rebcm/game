import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/game/dicas/dicas_widget.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Dicas widget responsivo em tela pequena', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 480));
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DicasWidget(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Dicas'), findsOneWidget);
    await tester.binding.setSurfaceSize(null);
  });

  testWidgets('Dicas widget truncamento em tela pequena', (tester) async {
    await tester.binding.setSurfaceSize(const Size(240, 480));
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DicasWidget(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Dicas'), findsOneWidget);
    await tester.binding.setSurfaceSize(null);
  });
}
