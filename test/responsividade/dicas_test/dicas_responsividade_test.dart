import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/game/docs/dicas_template/template.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Dicas de construção são legíveis em diferentes tamanhos de tela', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DicasTemplate(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final dicasText = find.text('Dicas de construção');
    expect(dicasText, findsOneWidget);

    await tester.binding.window.physicalSizeTestValue = Size(1920, 1080);
    await tester.pumpAndSettle();

    expect(dicasText, findsOneWidget);

    await tester.binding.window.physicalSizeTestValue = Size(1080, 1920);
    await tester.pumpAndSettle();

    expect(dicasText, findsOneWidget);

    await tester.binding.window.physicalSizeTestValue = Size(411, 823);
    await tester.pumpAndSettle();

    expect(dicasText, findsOneWidget);
  });
}
