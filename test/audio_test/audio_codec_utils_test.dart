import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/audio/audio_codec_utils.dart';

void main() {
  test('getSupportedCodec returns AAC', () {
    expect(AudioCodecUtils.getSupportedCodec(), 'AAC');
  });

  test('getSupportedCodecs returns list with AAC and MP3', () {
    expect(AudioCodecUtils.getSupportedCodecs(), ['AAC', 'MP3']);
  });

  test('getDefaultCodec returns AAC', () {
    expect(AudioCodecUtils.getDefaultCodec(), 'AAC');
  });
}
