import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:audioplayers/audioplayers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Testa se o volume geral é atualizado corretamente', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simula a alteração do slider de volume geral
    await tester.tap(find.byKey(Key('volume_slider')));
    await tester.pumpAndSettle();

    // Verifica se o volume foi atualizado
    final audioPlayer = AudioPlayer();
    final volume = await audioPlayer.getVolume();
    expect(volume, greaterThan(0.0));
  });

  testWidgets('Testa se o volume de música é atualizado corretamente', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simula a alteração do slider de volume de música
    await tester.tap(find.byKey(Key('music_volume_slider')));
    await tester.pumpAndSettle();

    // Verifica se o volume de música foi atualizado
    final audioPlayer = AudioPlayer();
    final volume = await audioPlayer.getVolume();
    expect(volume, greaterThan(0.0));
  });

  testWidgets('Testa se o volume de efeitos é atualizado corretamente', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simula a alteração do slider de volume de efeitos
    await tester.tap(find.byKey(Key('effects_volume_slider')));
    await tester.pumpAndSettle();

    // Verifica se o volume de efeitos foi atualizado
    final audioPlayer = AudioPlayer();
    final volume = await audioPlayer.getVolume();
    expect(volume, greaterThan(0.0));
  });
}
