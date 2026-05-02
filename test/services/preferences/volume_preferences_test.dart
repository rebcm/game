import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/preferences/volume_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('VolumePreferences', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
    });

    test('getVolumeMusic returns default value when key is not found', () async {
      final volume = await VolumePreferences.getVolumeMusic();
      expect(volume, 1.0);
    });

    test('getVolumeMusic returns saved value', () async {
      await VolumePreferences.setVolumeMusic(0.8);
      final volume = await VolumePreferences.getVolumeMusic();
      expect(volume, 0.8);
    });

    test('getVolumeAmbient returns default value when key is not found', () async {
      final volume = await VolumePreferences.getVolumeAmbient();
      expect(volume, 0.5);
    });

    test('getVolumeAmbient returns saved value', () async {
      await VolumePreferences.setVolumeAmbient(0.3);
      final volume = await VolumePreferences.getVolumeAmbient();
      expect(volume, 0.3);
    });

    test('getVolumeMusic returns default value when prefs is corrupted', () async {
      SharedPreferences.setMockInitialValues({_volumeMusicKey: 'invalid'});
      final volume = await VolumePreferences.getVolumeMusic();
      expect(volume, 1.0);
    });

    test('getVolumeAmbient returns default value when prefs is corrupted', () async {
      SharedPreferences.setMockInitialValues({_volumeAmbientKey: 'invalid'});
      final volume = await VolumePreferences.getVolumeAmbient();
      expect(volume, 0.5);
    });
  });
}
