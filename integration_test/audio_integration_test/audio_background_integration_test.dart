import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Testa se o áudio continua tocando quando o app está em background',
      (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    // Simula o áudio tocando
    final audioPlayer = AudioPlayer();
    await audioPlayer.play(AssetSource('audio/teste.mp3'));

    // Simula o app entrando em background
    await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);

    // Verifica se o áudio continua tocando
    expect(await audioPlayer.getPlayerState(), PlayerState.playing);

    // Simula o app voltando para o foreground
    await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);

    // Verifica se o áudio ainda está tocando
    expect(await audioPlayer.getPlayerState(), PlayerState.playing);

    await audioPlayer.stop();
    await audioPlayer.dispose();
  });
}
