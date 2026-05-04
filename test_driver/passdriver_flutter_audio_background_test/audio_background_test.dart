import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:audioplayers/audioplayers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Testar áudio em background', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simular o áudio tocando
    final AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(AssetSource('audio/teste.mp3'));

    // Simular o app entrando em background
    await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await Future.delayed(Duration(seconds: 2)); // Aguardar um pouco para verificar o comportamento

    // Verificar se o áudio continua tocando ou foi pausado corretamente
    final playerState = await audioPlayer.getPlayerState();
    expect(playerState, PlayerState.playing); // ou paused, dependendo do comportamento esperado

    // Simular o app voltando para o foreground
    await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await Future.delayed(Duration(seconds: 1)); // Aguardar um pouco para verificar o comportamento

    // Verificar novamente o estado do áudio
    final playerStateAfterResume = await audioPlayer.getPlayerState();
    expect(playerStateAfterResume, PlayerState.playing); // ou outro estado esperado

    await audioPlayer.stop();
  });
}
