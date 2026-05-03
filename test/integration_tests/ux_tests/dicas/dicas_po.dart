import 'package:flutter_test/flutter_test.dart';

class DicasPO {
  static Finder encontrarDica(String texto) {
    return find.text(texto);
  }

  static Future<void> simularAcaoConstrucao(WidgetTester tester) async {
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
  }

  static Future<void> simularAcaoConcluida(WidgetTester tester) async {
    await tester.tap(find.byIcon(Icons.check));
    await tester.pumpAndSettle();
  }
}
