import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/audio/audio_codec.dart';

void main() {
  test('Audio codec configuration test', () async {
    await AudioCodec.configureAudioCodec();
    expect(AudioCodec.preferredCodec, 'aac');
  });
}
