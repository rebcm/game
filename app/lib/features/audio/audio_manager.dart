import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  final AudioPlayer _musicPlayer = AudioPlayer();
  final AudioPlayer _sfxPlayer = AudioPlayer();

  Future<void> playMusic(String assetPath) async {
    await _musicPlayer.play(AssetSource(assetPath), mode: PlayerMode.LOW_LATENCY);
  }

  Future<void> playSfx(String assetPath) async {
    await _sfxPlayer.play(AssetSource(assetPath), mode: PlayerMode.LOW_LATENCY);
  }

  Future<void> stopMusic() async {
    await _musicPlayer.stop();
  }

  Future<void> stopSfx() async {
    await _sfxPlayer.stop();
  }
}
