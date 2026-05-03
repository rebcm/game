import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/audio_service.dart';
import 'package:mockito/mockito.dart';
import 'audio_player_mock.dart';

void main() {
  late MockAudioPlayer audioPlayerMock;
  late AudioService audioService;

  setUp(() {
    audioPlayerMock = MockAudioPlayer();
    setupAudioPlayerMock(audioPlayerMock);
    audioService = AudioService(audioPlayerMock);
  });

  test('should call setVolume with correct value', () async {
    const volume = 0.5;
    await audioService.setVolume(volume);
    verify(audioPlayerMock.setVolume(volume)).called(1);
  });

  test('should call play with correct source', () async {
    final source = FakeAudioPlayerSource();
    await audioService.play(source);
    verify(audioPlayerMock.play(source, mode: PlayerMode.lowLatency)).called(1);
  });
}
