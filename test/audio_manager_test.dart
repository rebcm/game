import 'package:flutter_test/flutter_test.dart';
import 'package:game/audio_manager/audio_manager.dart';

void main() {
  test('AudioManager initializes with default volume', () {
    final audioManager = AudioManager();
    expect(audioManager.volume, 1.0);
  });

  test('AudioManager sets volume correctly', () {
    final audioManager = AudioManager();
    audioManager.setVolume(0.5);
    expect(audioManager.volume, 0.5);
  });
}
