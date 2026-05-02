import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/personagem/rebeca.dart';

void simulaMovimentacaoRapida(WidgetTester tester, Rebeca rebeca) async {
  for (int i = 0; i < 10; i++) {
    rebeca.mover(1, 0);
    await tester.pumpAndSettle(Duration(milliseconds: 16));
  }
}
