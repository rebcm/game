import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/audio_manager/volume_guard.dart';

void main() {
  group('VolumeGuard', () {
    late VolumeGuard volumeGuard;

    setUp(() {
      volumeGuard = VolumeGuard();
    });

    test('should not update volume when isUpdating is true', () {
      volumeGuard.updateVolume(0.5);
      expect(volumeGuard.isUpdating, true);
      volumeGuard.updateVolume(0.7);
      // Add logic to verify volume is not updated
    });

    test('should update volume when isUpdating is false', () {
      volumeGuard.updateVolume(0.5);
      // Add logic to verify volume is updated
    });
  });
}
