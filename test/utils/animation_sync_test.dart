import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/animation_sync.dart';

void main() {
  group('AnimationSync', () {
    test('calculatePlaybackRate returns correct playback rate', () {
      const translationSpeed = 10.0;
      const animationSpeed = 5.0;
      expect(AnimationSync.calculatePlaybackRate(translationSpeed, animationSpeed), 2.0);
    });

    test('calculatePlaybackRate returns zero when translation speed is zero', () {
      const translationSpeed = 0.0;
      const animationSpeed = 5.0;
      expect(AnimationSync.calculatePlaybackRate(translationSpeed, animationSpeed), 0.0);
    });

    test('calculatePlaybackRate throws when animation speed is zero', () {
      const translationSpeed = 10.0;
      const animationSpeed = 0.0;
      expect(() => AnimationSync.calculatePlaybackRate(translationSpeed, animationSpeed), throwsA(isA<AssertionError>()));
    });
  });
}
