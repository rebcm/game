import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:rebcm/services/audio_manager.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Testa se o slider de volume geral afeta a saída de áudio', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simula a abertura das configurações de áudio
    await tester.tap(find.text('Configurações'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Áudio'));
    await tester.pumpAndSettle();

    // Obtém o valor inicial do slider de volume geral
    final initialGeneralVolume = tester.widget<Slider>(find.byType(Slider).first).value;

    // Move o slider de volume geral para o máximo
    await tester.drag(find.byType(Slider).first, Offset(100, 0));
    await tester.pumpAndSettle();

    // Verifica se o volume geral foi atualizado
    expect(AudioManager.generalVolume, isNot(initialGeneralVolume));

    // Verifica se a saída de áudio foi afetada
    expect(AudioManager.getCurrentVolume(), isNot(initialGeneralVolume));
  });

  testWidgets('Testa se o slider de volume de música afeta a saída de áudio', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simula a abertura das configurações de áudio
    await tester.tap(find.text('Configurações'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Áudio'));
    await tester.pumpAndSettle();

    // Obtém o valor inicial do slider de volume de música
    final initialMusicVolume = tester.widget<Slider>(find.byType(Slider).at(1)).value;

    // Move o slider de volume de música para o máximo
    await tester.drag(find.byType(Slider).at(1), Offset(100, 0));
    await tester.pumpAndSettle();

    // Verifica se o volume de música foi atualizado
    expect(AudioManager.musicVolume, isNot(initialMusicVolume));

    // Verifica se a saída de áudio foi afetada
    expect(AudioManager.getCurrentMusicVolume(), isNot(initialMusicVolume));
  });

  testWidgets('Testa se o slider de volume de efeitos afeta a saída de áudio', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simula a abertura das configurações de áudio
    await tester.tap(find.text('Configurações'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Áudio'));
    await tester.pumpAndSettle();

    // Obtém o valor inicial do slider de volume de efeitos
    final initialEffectsVolume = tester.widget<Slider>(find.byType(Slider).last).value;

    // Move o slider de volume de efeitos para o máximo
    await tester.drag(find.byType(Slider).last, Offset(100, 0));
    await tester.pumpAndSettle();

    // Verifica se o volume de efeitos foi atualizado
    expect(AudioManager.effectsVolume, isNot(initialEffectsVolume));

    // Verifica se a saída de áudio foi afetada
    expect(AudioManager.getCurrentEffectsVolume(), isNot(initialEffectsVolume));
  });
}
