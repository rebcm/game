import 'package:flutter_test/flutter_test.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:mockito/mockito.dart';
import 'package:game/audio_manager.dart';

class MockAudioPlayer extends Mock implements AudioPlayer {}

void main() {
  group('Audio Edge Cases Test', () {
    late AudioManager audioManager;
    late MockAudioPlayer mockAudioPlayer;

    setUp(() {
      mockAudioPlayer = MockAudioPlayer();
      audioManager = AudioManager(mockAudioPlayer);
    });

    test('test audio interruption by phone call', () async {
      when(mockAudioPlayer.play(AssetSource('sounds/background.mp3'))).thenAnswer((_) async => '1');
      await audioManager.playBackgroundMusic();
      verify(mockAudioPlayer.play(AssetSource('sounds/background.mp3'))).called(1);
      when(mockAudioPlayer.pause()).thenAnswer((_) async => '1');
      await audioManager.pauseBackgroundMusic();
      verify(mockAudioPlayer.pause()).called(1);
    });

    test('test audio in silent mode', () async {
      when(mockAudioPlayer.setVolume(0)).thenAnswer((_) async => '1');
      await audioManager.setSilentMode(true);
      verify(mockAudioPlayer.setVolume(0)).called(1);
    });

    test('test loss of connection', () async {
      when(mockAudioPlayer.play(AssetSource('sounds/background.mp3'))).thenThrow(Exception('Connection lost'));
      expect(() async => await audioManager.playBackgroundMusic(), throwsException);
    });

    test('test hardware permission denied', () async {
      when(mockAudioPlayer.play(AssetSource('sounds/background.mp3'))).thenThrow(Exception('Permission denied'));
      expect(() async => await audioManager.playBackgroundMusic(), throwsException);
    });
  });
}
