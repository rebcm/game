import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  testWidgets('Compatibilidade Test', (tester) async {
    await tester.pumpWidget(app.MyApp());
    // Adicionar testes de compatibilidade aqui
  });
}
