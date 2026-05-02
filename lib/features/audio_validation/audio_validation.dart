import 'package:flutter/foundation.dart';

class AudioValidation {
  static bool isFormatSupported(String format) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return format == 'ogg' || format == 'mp3';
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return format == 'mp3';
    }
    return false;
  }
}
