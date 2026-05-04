import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/game/audio/volume_controller.dart';

void main() {
  group('Volume Formula Test', () {
    test('should calculate final volume correctly', () {
      double volumeGlobal = 0.5;
      double volumeMusicaLocal = 0.8;
      double expectedVolumeFinal = 0.4;

      double volumeFinal = VolumeController.calculateVolume(volumeGlobal, volumeMusicaLocal);

      expect(volumeFinal, expectedVolumeFinal);
    });

    test('should handle zero global volume', () {
      double volumeGlobal = 0.0;
      double volumeMusicaLocal = 0.8;
      double expectedVolumeFinal = 0.0;

      double volumeFinal = VolumeController.calculateVolume(volumeGlobal, volumeMusicaLocal);

      expect(volumeFinal, expectedVolumeFinal);
    });

    test('should handle zero local music volume', () {
      double volumeGlobal = 0.5;
      double volumeMusicaLocal = 0.0;
      double expectedVolumeFinal = 0.0;

      double volumeFinal = VolumeController.calculateVolume(volumeGlobal, volumeMusicaLocal);

      expect(volumeFinal, expectedVolumeFinal);
    });
  });
}

