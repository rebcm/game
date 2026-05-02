import 'package:shared_preferences/shared_preferences.dart';

class AudioConfig {
  static const String _volumeKey = 'volume';
  static const String _musicVolumeKey = 'musicVolume';
  static const String _sfxVolumeKey = 'sfxVolume';

  static Future<double> getVolume() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_volumeKey) ?? 1.0;
  }

  static Future<void> setVolume(double volume) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_volumeKey, volume);
  }

  static Future<double> getMusicVolume() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_musicVolumeKey) ?? 1.0;
  }

  static Future<void> setMusicVolume(double volume) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_musicVolumeKey, volume);
  }

  static Future<double> getSfxVolume() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_sfxVolumeKey) ?? 1.0;
  }

  static Future<void> setSfxVolume(double volume) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_sfxVolumeKey, volume);
  }

  static Future<void> syncVolumes(double masterVolume) async {
    final musicVolume = await getMusicVolume();
    final sfxVolume = await getSfxVolume();
    await setMusicVolume(musicVolume * masterVolume);
    await setSfxVolume(sfxVolume * masterVolume);
  }
}
