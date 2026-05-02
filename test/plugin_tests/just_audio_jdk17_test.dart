import 'package:just_audio/just_audio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Just Audio compatibility test', () async {
    final player = AudioPlayer();
    await player.setAsset('assets/audio/optimized/ambient/ambient.mp3');
    expect(player, isNotNull);
  });
}
