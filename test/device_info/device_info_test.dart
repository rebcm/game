import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/device_info/device_info.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('getPlatformVersion', () async {
    final platformVersion = await DeviceInfo.getPlatformVersion();
    expect(platformVersion, isNotNull);
  });

  test('getDeviceResolution', () async {
    final deviceResolution = await DeviceInfo.getDeviceResolution();
    expect(deviceResolution, isNotNull);
    expect(deviceResolution, contains('x'));
  });
}
