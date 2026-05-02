import 'package:rebcm/config/audio_codec_config.dart';

class AudioCodecUtils {
  static String getSupportedCodec() {
    return AudioCodecConfig.supportedCodec;
  }

  static List<String> getSupportedCodecs() {
    return AudioCodecConfig.supportedCodecs;
  }

  static String getDefaultCodec() {
    return AudioCodecConfig.defaultCodec;
  }
}
