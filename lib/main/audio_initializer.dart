import 'package:rebcm/utils/audio/audio_codec.dart';

class AudioInitializer {
  static Future<void> init() async {
    await AudioCodec.configureAudioCodec();
  }
}
