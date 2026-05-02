import 'package:just_audio/just_audio.dart';
import 'package:rebcm/config/audio_codec_config.dart';

class AudioService {
  static AudioCodec getCodec() {
    return AudioCodec.${AudioCodecConfig.codec.toLowerCase()};
  }
}
