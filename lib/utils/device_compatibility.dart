import 'package:flutter/foundation.dart';

class DeviceCompatibility {
  static const String minAndroidVersion = '5.0';
  static const int minAndroidApiLevel = 21;
  static const String minIosVersion = '12.0';

  static bool isAndroidVersionSupported(String version) {
    return double.parse(version) >= double.parse(minAndroidVersion);
  }

  static bool isIosVersionSupported(String version) {
    return double.parse(version) >= double.parse(minIosVersion);
  }

  static bool isApiLevelSupported(int apiLevel) {
    return apiLevel >= minAndroidApiLevel;
  }
}
