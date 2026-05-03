import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/audio_service/audio_compressor.dart';

void main() {
  test('compress audio with ideal bitrate', () async {
    final compressor = AudioCompressor();
    await compressor.compressAudio('input.mp3', 'output.mp3', '128k');
    // Assert output.mp3 exists and is compressed
  });
}
