import 'package:flutter_test/flutter_test.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:mockito/mockito.dart';

class MockAudioPlayer extends Mock implements AudioPlayer {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AudioPlayer audioPlayer;

  setUp(() {
    audioPlayer = MockAudioPlayer();
  });

  test('test audio output switch between speaker and headphone', () async {
    when(audioPlayer.setReleaseMode(any)).thenAnswer((_) async => 1);
    when(audioPlayer.play(any, mode: anyNamed('mode'))).thenAnswer((_) async => 1);
    when(audioPlayer.stop()).thenAnswer((_) async => 1);

    await audioPlayer.setReleaseMode(ReleaseMode.stop);
    await audioPlayer.play(AssetSource('audio/test.mp3'), mode: PlayerMode.lowLatency);
    await audioPlayer.stop();

    verify(audioPlayer.setReleaseMode(ReleaseMode.stop)).called(1);
    verify(audioPlayer.play(AssetSource('audio/test.mp3'), mode: PlayerMode.lowLatency)).called(1);
    verify(audioPlayer.stop()).called(1);
  });

  test('test volume change with system volume change', () async {
    when(audioPlayer.setVolume(any)).thenAnswer((_) async => 1);

    await audioPlayer.setVolume(0.5);

    verify(audioPlayer.setVolume(0.5)).called(1);
  });
}
