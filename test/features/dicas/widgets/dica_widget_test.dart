import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/features/dicas/widgets/dica_widget.dart';

void main() {
  testWidgets('DicaWidget não deve mostrar dica para tela desconhecida', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: DicaWidget(telaAtual: 'TelaDesconhecida'),
    ));
    expect(find.byType(Tooltip), findsNothing);
    expect(find.byType(ElevatedButton), findsNothing);
  });

  testWidgets('DicaWidget deve mostrar Tooltip para gatilho configurado', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: DicaWidget(telaAtual: 'TelaConstrucao', gatilho: 'acaoConstruirBloco'),
    ));
    expect(find.byType(Tooltip), findsOneWidget);
  });

  testWidgets('DicaWidget deve mostrar Modal para gatilho configurado', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: DicaWidget(telaAtual: 'TelaInicial', gatilho: 'botaoIniciarConstrucao'),
    ));
    expect(find.byType(ElevatedButton), findsOneWidget);
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
  });
}
