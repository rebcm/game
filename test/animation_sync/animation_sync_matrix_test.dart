import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/animation_sync/animation_sync_matrix.dart';

void main() {
  group('AnimationSyncMatrix', () {
    test('getPlaybackRate returns correct playback rate for given velocity', () {
      expect(AnimationSyncMatrix.getPlaybackRate(0.0), 0.0);
      expect(AnimationSyncMatrix.getPlaybackRate(0.5), 0.5);
      expect(AnimationSyncMatrix.getPlaybackRate(1.0), 1.0);
      expect(AnimationSyncMatrix.getPlaybackRate(1.5), 1.5);
      expect(AnimationSyncMatrix.getPlaybackRate(2.0), 2.0);
    });

    test('getPlaybackRate interpolates correctly between matrix values', () {
      expect(AnimationSyncMatrix.getPlaybackRate(0.25), 0.25);
      expect(AnimationSyncMatrix.getPlaybackRate(0.75), 0.75);
    });

    test('getPlaybackRate returns last playback rate for velocity above max', () {
      expect(AnimationSyncMatrix.getPlaybackRate(2.5), 2.0);
    });
  });
}
