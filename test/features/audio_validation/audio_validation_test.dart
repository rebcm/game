import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/audio_validation/audio_validation.dart';

void main() {
  test('Android supports ogg and mp3', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    expect(AudioValidation.isFormatSupported('ogg'), true);
    expect(AudioValidation.isFormatSupported('mp3'), true);
    expect(AudioValidation.isFormatSupported('wav'), false);
  });

  test('iOS supports mp3', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    expect(AudioValidation.isFormatSupported('ogg'), false);
    expect(AudioValidation.isFormatSupported('mp3'), true);
    expect(AudioValidation.isFormatSupported('wav'), false);
  });
}
