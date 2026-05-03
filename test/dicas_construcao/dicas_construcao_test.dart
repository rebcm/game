import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as game;

void main() {
  testWidgets('Dicas de construção test', (tester) async {
    await tester.pumpWidget(game.MyApp());
    // Implementar testes específicos para as dicas de construção
  });
}
