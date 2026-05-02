import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> initAudio() async {
    await _audioPlayer.setSource(AssetSource('audio/sfx/colocar_bloco.ogg'));
  }

  Future<void> playSound(String sound) async {
    await _audioPlayer.play(AssetSource('audio/$sound.ogg'));
  }
}
