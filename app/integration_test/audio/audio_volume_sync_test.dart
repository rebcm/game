import 'package:flutter_test/flutter_test.dart';
import 'package:construcao_criativa/features/audio/audio_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AudioConfig', () {
    test('syncVolumes adjusts music and SFX volumes proportionally', () async {
      SharedPreferences.setMockInitialValues({});
      await AudioConfig.setMusicVolume(0.5);
      await AudioConfig.setSfxVolume(0.8);
      await AudioConfig.syncVolumes(0.7);

      final musicVolume = await AudioConfig.getMusicVolume();
      final sfxVolume = await AudioConfig.getSfxVolume();

      expect(musicVolume, closeTo(0.35, 0.01));
      expect(sfxVolume, closeTo(0.56, 0.01));
    });
  });
}
