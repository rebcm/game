import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:construcao_criativa/features/audio/audio_manager.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Audio loop test', (tester) async {
    await tester.pumpAndSettle();
    final audioManager = AudioManager();
    await audioManager.playMusic('assets/audio/music/dia_01.ogg', loop: true);
    await tester.pump(Duration(seconds: 2));
    await audioManager.stopMusic();
    await tester.pump(Duration(seconds: 1));
  });
}
