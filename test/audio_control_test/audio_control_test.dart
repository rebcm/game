import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:game/services/audio_control_service.dart';
import 'package:audioplayers/audioplayers.dart';

class MockAudioPlayer extends Mock implements AudioPlayer {}

void main() {
  group('AudioControlService', () {
    late AudioControlService audioControlService;
    late MockAudioPlayer mockAudioPlayer;

    setUp(() {
      mockAudioPlayer = MockAudioPlayer();
      audioControlService = AudioControlService(mockAudioPlayer);
    });

    test('should call setVolume with correct parameter when volume is changed', () async {
      const double volume = 0.5;
      await audioControlService.setVolume(volume);
      verify(mockAudioPlayer.setVolume(volume)).called(1);
    });
  });
}
