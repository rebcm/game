import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('documentacao teste de integração', (tester) async {
    // Implementação do teste de integração para a documentação
    await tester.pumpWidget(MyApp());
    expect(find.text('Rebeca Alves Moreira'), findsOneWidget);
  });
}
