import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver? driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      driver!.close();
    }
  });

  test('Audio settings test', () async {
    final settingsButton = find.byValueKey('settings_button');
    await driver!.waitFor(settingsButton);
    await driver!.tap(settingsButton);

    final musicMuteSwitch = find.byValueKey('music_mute_switch');
    await driver!.waitFor(musicMuteSwitch);
    await driver!.tap(musicMuteSwitch);

    final sfxMuteSwitch = find.byValueKey('sfx_mute_switch');
    await driver!.waitFor(sfxMuteSwitch);
    await driver!.tap(sfxMuteSwitch);

    final musicVolumeSlider = find.byValueKey('music_volume_slider');
    await driver!.waitFor(musicVolumeSlider);
    await driver!.scroll(musicVolumeSlider, 0.5, 0, Duration(milliseconds: 100));

    final sfxVolumeSlider = find.byValueKey('sfx_volume_slider');
    await driver!.waitFor(sfxVolumeSlider);
    await driver!.scroll(sfxVolumeSlider, 0.5, 0, Duration(milliseconds: 100));
  });
}
