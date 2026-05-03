import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/game/game.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Testes de breakpoints para dicas', () {
    testWidgets('Verificar layout em diferentes breakpoints', (tester) async {
      await tester.pumpWidget(MyApp());

      await tester.pumpAndSettle();

      final breakpoints = [480, 768, 1024];

      for (var breakpoint in breakpoints) {
        await tester.binding.setSurfaceSize(Size(breakpoint, breakpoint * 1.77));
        await tester.pumpAndSettle();

        expect(find.text('Dica'), findsOneWidget);
      }
    });
  });
}
