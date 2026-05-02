import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/audio/audio_player_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AudioPlayerService', () {
    test('init sets volume and mute state from prefs', () async {
      final service = AudioPlayerService();
      await service.init();
      // Add assertions here based on expected initial state
    });

    test('setVolume changes volume', () async {
      final service = AudioPlayerService();
      await service.init();
      await service.setVolume(0.5);
      // Add assertions here to verify volume change
    });

    test('toggleMute mutes and unmutes', () async {
      final service = AudioPlayerService();
      await service.init();
      await service.toggleMute();
      // Add assertions here to verify mute state change
    });
  });
}
