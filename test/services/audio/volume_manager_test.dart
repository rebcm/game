import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/audio/volume_manager.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:mockito/mockito.dart';

class MockAudioPlayer extends Mock implements AudioPlayer {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('VolumeManager', () {
    late VolumeManager volumeManager;
    late MockAudioPlayer mockAudioPlayer;

    setUp(() {
      mockAudioPlayer = MockAudioPlayer();
      volumeManager = VolumeManager(mockAudioPlayer);
    });

    test('initializes volume listener', () async {
      when(mockAudioPlayer.setVolume(1.0)).thenAnswer((_) async => 1);
      await volumeManager._initVolumeListener();
      verify(mockAudioPlayer.setVolume(1.0)).called(1);
    });

    test('sets volume', () async {
      when(mockAudioPlayer.setVolume(0.5)).thenAnswer((_) async => 1);
      await volumeManager.setVolume(0.5);
      verify(mockAudioPlayer.setVolume(0.5)).called(1);
    });

    test('gets volume', () async {
      when(mockAudioPlayer.getVolume()).thenAnswer((_) async => 0.5);
      final volume = await volumeManager.getVolume();
      expect(volume, 0.5);
      verify(mockAudioPlayer.getVolume()).called(1);
    });

    test('handles platform exception on setVolume', () async {
      when(mockAudioPlayer.setVolume(0.5)).thenThrow(PlatformException(code: 'error', message: 'test error'));
      await volumeManager.setVolume(0.5);
      verify(mockAudioPlayer.setVolume(0.5)).called(1);
    });

    test('handles platform exception on getVolume', () async {
      when(mockAudioPlayer.getVolume()).thenThrow(PlatformException(code: 'error', message: 'test error'));
      final volume = await volumeManager.getVolume();
      expect(volume, 1.0);
      verify(mockAudioPlayer.getVolume()).called(1);
    });
  });
}
