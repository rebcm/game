import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/device/device_info.dart';

void main() {
  test('getPlatformVersion', () async {
    final version = await DeviceInfo.getPlatformVersion();
    expect(version, isNotNull);
  });

  test('getDeviceResolution', () async {
    final resolution = await DeviceInfo.getDeviceResolution();
    expect(resolution, isNotNull);
    expect(resolution, contains('x'));
  });
}
