import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class DeviceInfo {
  static Future<String> getPlatformVersion() async {
    try {
      final platformVersion = await MethodChannel('com.rebcm.game/platform_version').invokeMethod('getPlatformVersion');
      return platformVersion;
    } on PlatformException catch (e) {
      return "Failed to get platform version: '${e.message}'.";
    }
  }

  static Future<String> getDeviceResolution() async {
    // Implementação para obter a resolução do dispositivo
    // Esta é uma implementação simplificada e pode precisar ser adaptada
    return '${window.physicalSize.width}x${window.physicalSize.height}';
  }
}
