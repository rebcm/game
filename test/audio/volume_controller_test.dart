import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/audio/volume_controller.dart';

void main() {
  test('should set and get volume', () async {
    final volumeController = VolumeController();
    await volumeController.setVolume(0.5);
    final volume = await volumeController.getVolume();
    expect(volume, 0.5);
  });
}
