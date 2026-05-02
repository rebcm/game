import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/audio/audio_player_service.dart';

void main() {
  group('AudioPlayerService', () {
    late AudioPlayerService audioPlayerService;

    setUp(() {
      audioPlayerService = AudioPlayerService();
    });

    test('initial volume is 1.0', () {
      expect(audioPlayerService.getVolume(), 1.0);
    });

    test('setVolume changes volume', () async {
      await audioPlayerService.setVolume(0.5);
      expect(audioPlayerService.getVolume(), 0.5);
    });

    test('toggleMute mutes and unmutes', () async {
      await audioPlayerService.toggleMute();
      expect(audioPlayerService.isMuted(), true);
      await audioPlayerService.toggleMute();
      expect(audioPlayerService.isMuted(), false);
    });
  });
}
