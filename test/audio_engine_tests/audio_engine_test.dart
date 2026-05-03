import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:game/audio_engine.dart';

class MockAudioPlayer extends Mock implements AudioPlayer {}

void main() {
  group('AudioEngine', () {
    late AudioEngine audioEngine;
    late MockAudioPlayer mockAudioPlayer;

    setUp(() {
      mockAudioPlayer = MockAudioPlayer();
      audioEngine = AudioEngine(mockAudioPlayer);
    });

    test('setVolume calls audioPlayer.setVolume', () {
      const volume = 0.5;
      audioEngine.setVolume(volume);
      verify(mockAudioPlayer.setVolume(volume)).called(1);
    });
  });
}
