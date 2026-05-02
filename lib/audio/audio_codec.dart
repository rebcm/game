import 'package:flutter/foundation.dart';

class AudioCodec {
  static const String supportedCodec = 'AAC';

  static bool isCodecSupported(String codec) {
    return codec == supportedCodec;
  }
}
