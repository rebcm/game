import 'package:flutter_test/flutter_test.dart';
import 'package:game/constants/hardware_constants.dart';

void main() {
  test('HardwareConstants - lowEndDevices', () {
    expect(HardwareConstants.lowEndDevices, isNotEmpty);
  });

  test('HardwareConstants - midEndDevices', () {
    expect(HardwareConstants.midEndDevices, isNotEmpty);
  });

  test('HardwareConstants - highEndDevices', () {
    expect(HardwareConstants.highEndDevices, isNotEmpty);
  });

  test('HardwareConstants - minFps', () {
    expect(HardwareConstants.minFps, isNotEmpty);
  });

  test('HardwareConstants - recommendedFps', () {
    expect(HardwareConstants.recommendedFps, isNotEmpty);
  });

  test('HardwareConstants - maxLoadingTime', () {
    expect(HardwareConstants.maxLoadingTime, isNotEmpty);
  });
}
