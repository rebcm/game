import 'package:shared_preferences/shared_preferences.dart';

class Volume {
  static Future<double> getVolume() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('volume') ?? 0.5;
  }

  static Future<void> setVolume(double volume) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('volume', volume);
  }
}
