import 'package:flutter_test/flutter_test.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('audio latency stress test', () async {
    final audioPlayer = AudioPlayer();
    await audioPlayer.play(AssetSource('audio/optimized/music/test.mp3'), loop: true);
    await Future.delayed(Duration(seconds: 10));
    await audioPlayer.stop();
  });
}
