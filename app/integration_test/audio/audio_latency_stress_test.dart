import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Audio latency stress test', (tester) async {
    final audioPlayer = AudioPlayer();
    await audioPlayer.setSource(AssetSource('audio/sfx/colocar_bloco.ogg'));

    const iterations = 100;
    final latencies = <int>[];

    for (var i = 0; i < iterations; i++) {
      final stopwatch = Stopwatch()..start();
      await audioPlayer.resume();
      await audioPlayer.stop();
      latencies.add(stopwatch.elapsed.inMilliseconds);
      await Future.delayed(const Duration(milliseconds: 50));
    }

    final averageLatency = latencies.reduce((a, b) => a + b) / iterations;
    print('Average audio latency: $averageLatency ms');

    expect(averageLatency, lessThan(200));
  });
}
