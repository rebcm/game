import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/persistence.dart';

void main() {
  group('Persistence Volume', () {
    test('should handle null values', () async {
      await Persistence.saveVolume(null);
      final volume = await Persistence.loadVolume();
      expect(volume, null);
    });

    test('should handle extreme values', () async {
      await Persistence.saveVolume(0.0);
      final volume = await Persistence.loadVolume();
      expect(volume, 0.0);

      await Persistence.saveVolume(1.0);
      final volume2 = await Persistence.loadVolume();
      expect(volume2, 1.0);
    });

    test('should handle invalid values', () async {
      await Persistence.saveVolume(-1.0);
      final volume = await Persistence.loadVolume();
      expect(volume, null);

      await Persistence.saveVolume(2.0);
      final volume2 = await Persistence.loadVolume();
      expect(volume2, null);
    });
  });
}
