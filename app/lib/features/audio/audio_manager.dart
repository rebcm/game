import 'package:audioplayers/audioplayers.dart';
import 'package:construcao_criativa/features/audio/audio_config.dart';

class AudioManager {
  final AudioPlayer _musicPlayer = AudioPlayer();
  final AudioPlayer _sfxPlayer = AudioPlayer();

  Future<void> playMusic(String filePath) async {
    final volume = await AudioConfig.getMusicVolume();
    await _musicPlayer.play(AssetSource(filePath), volume: volume);
  }

  Future<void> playSfx(String filePath) async {
    final volume = await AudioConfig.getSfxVolume();
    await _sfxPlayer.play(AssetSource(filePath), volume: volume);
  }

  Future<void> setMasterVolume(double volume) async {
    await AudioConfig.setVolume(volume);
    await AudioConfig.syncVolumes(volume);
  }

  Future<void> setMusicVolume(double volume) async {
    await AudioConfig.setMusicVolume(volume);
  }

  Future<void> setSfxVolume(double volume) async {
    await AudioConfig.setSfxVolume(volume);
  }
}
