import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:construcao_criativa/features/audio/audio_manager.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('measure audio latency', (tester) async {
    final audioManager = AudioManager();
    await audioManager.initAudio();

    final stopwatch = Stopwatch()..start();
    await audioManager.playSound('sfx/colocar_bloco');
    final latency = stopwatch.elapsed.inMilliseconds;

    expect(latency, lessThan(100));
  });
}
