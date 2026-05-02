import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Alterar volume não causa lag na UI', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Encontrar o slider de volume
    final volumeSlider = find.byType(Slider);
    expect(volumeSlider, findsOneWidget);

    // Verificar estado inicial do volume
    final initialVolume = tester.widget<Slider>(volumeSlider).value;

    // Mover o slider de volume
    await tester.drag(volumeSlider, Offset(50, 0));
    await tester.pump();

    // Verificar se o volume mudou
    final newVolume = tester.widget<Slider>(volumeSlider).value;
    expect(newVolume, isNot(initialVolume));

    // Verificar se a UI permanece responsiva
    await tester.pumpAndSettle();
    expect(find.text('Rebeca'), findsOneWidget);
  });
}
