import 'dart:io';

class AndroidVersionCheck {
  bool isAndroid13OrHigher() {
    if (Platform.isAndroid) {
      final androidInfo = AndroidDeviceInfo();
      return androidInfo.version.sdkInt >= 33;
    }
    return false;
  }
}
