import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/audio/audio_codec.dart';

void main() {
  test('should return true for supported codec', () {
    expect(AudioCodec.isCodecSupported('AAC'), true);
  });

  test('should return false for unsupported codec', () {
    expect(AudioCodec.isCodecSupported('MP3'), false);
  });
}
