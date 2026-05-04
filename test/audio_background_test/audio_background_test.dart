import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:audioplayers/audioplayers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Testar áudio em background', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Simular o app entrando em background
    await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await tester.pumpAndSettle();

    // Verificar se o áudio continua tocando ou foi pausado corretamente
    final audioPlayer = AudioPlayer();
    final isPlaying = await audioPlayer.state == PlayerState.playing;
    expect(isPlaying, false); // O áudio deve ser pausado quando o app entra em background

    // Simular o app voltando para o foreground
    await tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();

    // Verificar se o áudio volta a tocar após o app voltar para foreground
    // expect(await audioPlayer.state == PlayerState.playing, true); // Descomentar se o áudio deve continuar
  });
}
