import 'package:flutter/foundation.dart';

class VersionUtils {
  static void checkFlutterVersion() {
    final flutterVersion = flutterVersionString();
    if (!flutterVersion.startsWith('Flutter 3.0.')) {
      debugPrint('Flutter version mismatch: $flutterVersion');
      // Adicione lógica para lidar com a versão incompatível aqui
    }
  }

  static void checkDartVersion() {
    final dartVersion = dartVersionString();
    if (!dartVersion.startsWith('Dart 2.17.')) {
      debugPrint('Dart version mismatch: $dartVersion');
      // Adicione lógica para lidar com a versão incompatível aqui
    }
  }

  static String flutterVersionString() {
    return '${FlutterVersion.current.channel} ${FlutterVersion.current.version}';
  }

  static String dartVersionString() {
    return 'Dart ${Platform.version}';
  }
}
