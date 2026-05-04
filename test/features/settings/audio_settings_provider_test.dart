import 'package:flutter_test/flutter_test.dart';
import 'package:game/features/settings/providers/audio_settings_provider.dart';

void main() {
  test('toggleMusicMute', () {
    final provider = AudioSettingsProvider();
    expect(provider.isMusicMuted, false);
    provider.toggleMusicMute();
    expect(provider.isMusicMuted, true);
  });

  test('toggleSfxMute', () {
    final provider = AudioSettingsProvider();
    expect(provider.isSfxMuted, false);
    provider.toggleSfxMute();
    expect(provider.isSfxMuted, true);
  });

  test('setMusicVolume', () {
    final provider = AudioSettingsProvider();
    expect(provider.musicVolume, 1.0);
    provider.setMusicVolume(0.5);
    expect(provider.musicVolume, 0.5);
  });

  test('setSfxVolume', () {
    final provider = AudioSettingsProvider();
    expect(provider.sfxVolume, 1.0);
    provider.setSfxVolume(0.5);
    expect(provider.sfxVolume, 0.5);
  });
}
