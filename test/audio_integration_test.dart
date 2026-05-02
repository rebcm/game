import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rebcm/audio/audio_codec_config.dart';

void main() {
  test('Audio integration test', () async {
    final player = AudioPlayer();
    await player.setAsset('assets/audio/optimized/ambient/sample.aac');
    expect(player.audioFormat, AudioFormat(AudioCodecConfig.supportedCodec));
  });
}
