import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:construcao_criativa/features/audio/audio_manager.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Audio latency test', (tester) async {
    final audioManager = AudioManager();
    await audioManager.initAudio();
    final stopwatch = Stopwatch()..start();
    await audioManager.playSound('sfx/colocar_bloco.ogg');
    await Future.delayed(const Duration(milliseconds: 100));
    final latency = stopwatch.elapsedMilliseconds;
    expect(latency, lessThan(50));
  });
}
