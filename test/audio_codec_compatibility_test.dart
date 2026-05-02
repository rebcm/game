import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/audio/audio_codec_config.dart';

void main() {
  test('Audio codec compatibility test', () {
    expect(AudioCodecConfig.supportedCodec, 'AAC');
    expect(AudioCodecConfig.supportedExtensions, ['.aac', '.m4a']);
  });
}
