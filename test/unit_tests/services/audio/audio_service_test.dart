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

  test('init', () async {
    when(() => _audioPlayer.initialize()).thenAnswer((_) async {});
    await _audioService.init();
    verify(() => _audioPlayer.initialize()).called(1);
  });

  test('play', () async {
    when(() => _audioPlayer.play()).thenAnswer((_) async {});
    await _audioService.play();
    verify(() => _audioPlayer.play()).called(1);
  });

  test('pause', () async {
    when(() => _audioPlayer.pause()).thenAnswer((_) async {});
    await _audioService.pause();
    verify(() => _audioPlayer.pause()).called(1);
  });

  test('setVolume', () async {
    when(() => _audioPlayer.setVolume(0.5)).thenAnswer((_) async {});
    await _audioService.setVolume(0.5);
    verify(() => _audioPlayer.setVolume(0.5)).called(1);
  });

  test('setMute', () async {
    when(() => _audioPlayer.setVolume(0)).thenAnswer((_) async {});
    await _audioService.setMute(true);
    verify(() => _audioPlayer.setVolume(0)).called(1);
  });

  test('getVolume', () {
    when(() => _audioPlayer.volume).thenReturn(0.5);
    expect(_audioService.getVolume(), 0.5);
  });

  test('isMuted', () {
    when(() => _audioPlayer.volume).thenReturn(0);
    expect(_audioService.isMuted(), true);
  });
}
