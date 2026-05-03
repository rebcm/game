import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AudioImpl {
  static const platform = const MethodChannel('game/audio');

  static Future<void> setAudioOutput(int output) async {
    await platform.invokeMethod('setAudioOutput', {'output': output});
  }

  static Future<void> setSilentMode(bool enabled) async {
    await platform.invokeMethod('setSilentMode', {'enabled': enabled});
  }
}
