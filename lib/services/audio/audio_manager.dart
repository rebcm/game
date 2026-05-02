import 'package:just_audio/just_audio.dart';
import 'package:rebcm/services/audio/audio_player_service.dart';

class AudioManager {
  final AudioPlayer _ambientPlayer = AudioPlayer();
  final AudioPlayer _effectPlayer = AudioPlayer();
  final AudioPlayer _musicPlayer = AudioPlayer();

  Future<void> init() async {
    await _ambientPlayer.setVolume(1.0);
    await _effectPlayer.setVolume(1.0);
    await _musicPlayer.setVolume(1.0);
  }

  Future<void> playAmbient(String assetPath) async {
    await _ambientPlayer.setAsset(assetPath);
    _ambientPlayer.play();
  }

  Future<void> playEffect(String assetPath) async {
    await _effectPlayer.setAsset(assetPath);
    _effectPlayer.play();
  }

  Future<void> playMusic(String assetPath) async {
    await _musicPlayer.setAsset(assetPath);
    _musicPlayer.play();
  }

  void stopAmbient() {
    _ambientPlayer.stop();
  }

  void stopEffect() {
    _effectPlayer.stop();
  }

  void stopMusic() {
    _musicPlayer.stop();
  }
}
