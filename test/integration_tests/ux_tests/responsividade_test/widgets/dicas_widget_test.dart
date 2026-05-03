import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/game/widgets/dicas.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('test wrap e truncamento de dicas', (tester) async {
    await tester.pumpWidget(const DicasWidget());
    await tester.binding.setSurfaceSize(const Size(300, 200));
    await tester.pumpAndSettle();

    expect(find.text('Dica'), findsOneWidget);
  });
}
