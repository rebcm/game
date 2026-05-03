import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/config/input_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('InputConfig', () {
    test('initial deadzone threshold is 0.1', () async {
      final inputConfig = InputConfig();
      expect(inputConfig.deadzoneThreshold, 0.1);
    });

    test('setDeadzoneThreshold updates the value', () async {
      final inputConfig = InputConfig();
      await inputConfig.setDeadzoneThreshold(0.5);
      expect(inputConfig.deadzoneThreshold, 0.5);
    });

    test('loads deadzone threshold from shared preferences', () async {
      SharedPreferences.setMockInitialValues({ 'deadzone_threshold': 0.2 });
      final inputConfig = InputConfig();
      await Future.delayed(Duration(milliseconds: 1)); // Allow async load to complete
      expect(inputConfig.deadzoneThreshold, 0.2);
    });
  });
}
