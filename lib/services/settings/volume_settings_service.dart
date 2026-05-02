import 'package:shared_preferences/shared_preferences.dart';

class VolumeSettingsService {
  static const String _volumeKey = 'volume';
  static const String _muteKey = 'mute';

  Future<double> getVolume() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_volumeKey) ?? 1.0;
  }

  Future<void> setVolume(double volume) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_volumeKey, volume);
  }

  Future<bool> getMute() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_muteKey) ?? false;
  }

  Future<void> setMute(bool mute) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_muteKey, mute);
  }
}
