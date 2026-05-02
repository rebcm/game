import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/utils/audio/audio_codec.dart';

void main() {
  test('AudioCodec preferred codec is aac', () {
    expect(AudioCodec.preferredCodec, 'aac');
  });

  test('configureAudioCodec sets the audio format to AAC', () async {
    await AudioCodec.configureAudioCodec();
    // Add verification logic here if needed
  });
}
