import 'package:shared_preferences/shared_preferences.dart';

class Volume {
  static const defaultValue = 0.5;
  final SharedPreferences _prefs;

  Volume(this._prefs);

  double get value {
    final storedValue = _prefs.getDouble('volume');
    if (storedValue == null) return defaultValue;
    if (storedValue < 0.0 || storedValue > 1.0) return defaultValue;
    return storedValue;
  }

  set value(double value) {
    _prefs.setDouble('volume', value);
  }
}
