import 'package:shared_preferences/shared_preferences.dart';

class Volume {
  final double value;

  Volume(this.value);

  factory Volume.fromPersistence(SharedPreferences prefs) {
    try {
      final volume = prefs.getString('volume');
      if (volume == null) {
        throw Exception('Volume not found');
      }
      final volumeValue = double.parse(volume);
      if (volumeValue < 0.0 || volumeValue > 1.0) {
        throw Exception('Volume out of range');
      }
      return Volume(volumeValue);
    } catch (e) {
      throw Exception('Failed to parse volume: $e');
    }
  }
}
