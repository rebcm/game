import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/audio_validation/audio_validation.dart';

void main() {
  test('should validate ogg format support', () async {
    final isSupported = await validateAudioFormat('ogg');
    expect(isSupported, true);
  });

  test('should validate mp3 format support', () async {
    final isSupported = await validateAudioFormat('mp3');
    expect(isSupported, true);
  });

  test('should return false for unsupported format', () async {
    final isSupported = await validateAudioFormat('wav');
    expect(isSupported, false);
  });
}
