import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/audio/volume_controller.dart';

void main() {
  test('VolumeController instance is singleton', () {
    expect(VolumeController.instance, VolumeController.instance);
  });

  test('setVolume changes currentVolume', () {
    VolumeController.instance.setVolume(0.7);
    expect(VolumeController.instance.currentVolume, 0.7);
  });

  test('toggleMute mutes and unmutes', () {
    VolumeController.instance.toggleMute();
    expect(VolumeController.instance.isMuted, true);
    VolumeController.instance.toggleMute();
    expect(VolumeController.instance.isMuted, false);
  });
}
