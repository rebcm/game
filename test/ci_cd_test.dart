import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  testWidgets('CI/CD pipeline test', (tester) async {
    await tester.pumpWidget(app.MyApp());
    // Adicione aqui as verificações necessárias para o teste do pipeline CI/CD
  });
}
