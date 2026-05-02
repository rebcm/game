import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/config/audio_codec_config.dart';

void main() {
  test('Audio codec configuration test', () {
    expect(AudioCodecConfig.codec, 'AAC');
  });
}
