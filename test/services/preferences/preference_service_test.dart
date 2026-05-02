import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/preferences/preference_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('PreferenceService', () {
    test('getVolume returns default when key is missing', () async {
      SharedPreferences.setMockInitialValues({});
      final service = PreferenceService();
      expect(await service.getVolume(), 1.0);
    });

    test('getVolume returns stored value', () async {
      SharedPreferences.setMockInitialValues({'volume': 0.5});
      final service = PreferenceService();
      expect(await service.getVolume(), 0.5);
    });

    test('setVolume stores value', () async {
      SharedPreferences.setMockInitialValues({});
      final service = PreferenceService();
      await service.setVolume(0.7);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getDouble('volume'), 0.7);
    });
  });
}
