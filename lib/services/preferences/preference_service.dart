import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static const String _volumeKey = 'volume';

  Future<double> getVolume() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getDouble(_volumeKey) ?? 1.0;
    } catch (e) {
      return 1.0;
    }
  }

  Future<void> setVolume(double volume) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_volumeKey, volume);
    } catch (e) {
      // Handle error silently for now
    }
  }
}
