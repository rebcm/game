import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/device_compatibility.dart';

void main() {
  group('DeviceCompatibility', () {
    test('isAndroidVersionSupported', () {
      expect(DeviceCompatibility.isAndroidVersionSupported('4.4'), false);
      expect(DeviceCompatibility.isAndroidVersionSupported('5.0'), true);
      expect(DeviceCompatibility.isAndroidVersionSupported('6.0'), true);
    });

    test('isIosVersionSupported', () {
      expect(DeviceCompatibility.isIosVersionSupported('11.0'), false);
      expect(DeviceCompatibility.isIosVersionSupported('12.0'), true);
      expect(DeviceCompatibility.isIosVersionSupported('13.0'), true);
    });

    test('isApiLevelSupported', () {
      expect(DeviceCompatibility.isApiLevelSupported(20), false);
      expect(DeviceCompatibility.isApiLevelSupported(21), true);
      expect(DeviceCompatibility.isApiLevelSupported(22), true);
    });
  });
}
