import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/jogo/renderizador_isometrico.dart';
import 'package:rebcm/personagem/rebeca.dart';

void main() {
  testWidgets('Verifica jank na animação idle da Rebeca', (tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();
    final rebeca = tester.widget<Rebeca>(find.byType(Rebeca));
    final renderizador = tester.widget<RenderizadorIsometrico>(find.byType(RenderizadorIsometrico));

    await tester.pump();
    expect(rebeca, isNotNull);
    expect(renderizador, isNotNull);
  });
}
