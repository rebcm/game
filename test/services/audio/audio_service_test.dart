import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rebcm/services/audio/audio_service.dart';

class MockAudioPlayer extends Mock implements AudioPlayer {}

void main() {
  late AudioServiceImpl _audioService;
  late MockAudioPlayer _audioPlayer;

  setUp(() {
    _audioPlayer = MockAudioPlayer();
    _audioService = AudioServiceImpl(_audioPlayer);
  });

  test('init sets volume to 1.0', () async {
    when(() => _audioPlayer.setVolume(1.0)).thenAnswer((_) async => null);
    await _audioService.init();
    verify(() => _audioPlayer.setVolume(1.0)).called(1);
  });

  test('setVolume sets the volume', () async {
    when(() => _audioPlayer.setVolume(0.5)).thenAnswer((_) async => null);
    await _audioService.setVolume(0.5);
    verify(() => _audioPlayer.setVolume(0.5)).called(1);
  });

  test('toggleMute toggles the volume', () async {
    when(() => _audioPlayer.volume).thenReturn(1.0);
    when(() => _audioPlayer.setVolume(0.0)).thenAnswer((_) async => null);
    await _audioService.toggleMute();
    verify(() => _audioPlayer.setVolume(0.0)).called(1);
  });

  test('getVolume returns the current volume', () {
    when(() => _audioPlayer.volume).thenReturn(0.5);
    expect(_audioService.getVolume(), 0.5);
  });
}
