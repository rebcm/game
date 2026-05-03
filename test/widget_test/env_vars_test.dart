import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart';

void main() {
  testWidgets('Testa se as variáveis de ambiente estão acessíveis',
      (tester) async {
    await tester.pumpWidget(MyApp());

    // Aqui você pode adicionar testes para verificar se as variáveis estão sendo usadas corretamente
  });
}
