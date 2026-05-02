import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/audio/audio_service.dart';
void main() {
  test('playAudio', () async {
    final audioService = AudioService();
    await audioService.playAudio('https://example.com/audio.mp3');
  });
  test('stopAudio', () async {
    final audioService = AudioService();
    await audioService.stopAudio();
  });
}
