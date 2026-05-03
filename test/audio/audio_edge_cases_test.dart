import 'package:flutter_test/flutter_test.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AudioPlayer audioPlayer;

  setUp(() {
    audioPlayer = AudioPlayer();
  });

  test('test audio output switch between speaker and headphone', () async {
    await audioPlayer.setReleaseMode(ReleaseMode.stop);
    await audioPlayer.play(AssetSource('audio/test.mp3'), mode: PlayerMode.lowLatency);
    await audioPlayer.stop();
  });

  test('test volume change with system volume change', () async {
    await audioPlayer.setVolume(0.5);
  });
}
