import 'package:flutter_test/flutter_test.dart';
import 'package:game/guia_construcao.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Guia de Construção', (tester) async {
    await tester.pumpWidget(GuiaConstrucao());
    expect(find.text('Guia de Construção'), findsOneWidget);
  });
}
