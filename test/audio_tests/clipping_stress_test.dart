import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/audio_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Audio Clipping Stress Test', () {
    test('should not exceed maximum decibel limit', () async {
      await AudioManager.instance.initialize();
      final maxDecibels = await AudioManager.instance.getMaxDecibels();
      final currentVolume = await AudioManager.instance.getCurrentVolume();

      expect(currentVolume, lessThanOrEqualTo(maxDecibels));
    });

    test('should play multiple sounds without clipping', () async {
      await AudioManager.instance.initialize();
      final maxDecibels = await AudioManager.instance.getMaxDecibels();

      for (var i = 0; i < 10; i++) {
        await AudioManager.instance.playSound('placeholder_sfx.mp3');
        final currentVolume = await AudioManager.instance.getCurrentVolume();
        expect(currentVolume, lessThanOrEqualTo(maxDecibels));
      }
    });
  });
}
