import 'package:shared_preferences/shared_preferences.dart';

class VolumePreferences {
  static const String _volumeMusicKey = 'volumeMusic';
  static const String _volumeAmbientKey = 'volumeAmbient';

  static Future<double> getVolumeMusic() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getDouble(_volumeMusicKey) ?? 1.0;
    } catch (e) {
      return 1.0;
    }
  }

  static Future<void> setVolumeMusic(double volume) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_volumeMusicKey, volume);
  }

  static Future<double> getVolumeAmbient() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getDouble(_volumeAmbientKey) ?? 0.5;
    } catch (e) {
      return 0.5;
    }
  }

  static Future<void> setVolumeAmbient(double volume) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_volumeAmbientKey, volume);
  }
}
