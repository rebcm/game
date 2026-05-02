import 'package:just_audio/just_audio.dart';

class AudioCodec {
  static const String preferredCodec = 'aac';

  static Future<void> configureAudioCodec() async {
    await AudioPlayer.setAudioDecoderFormat(
      AudioDecoderFormat.aacLc, // Using AAC-LC for compatibility
    );
  }
}
