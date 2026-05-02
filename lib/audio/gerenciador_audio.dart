import 'package:audioplayers/audioplayers.dart';

class GerenciadorAudio {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> tocarAudio(String caminho) async {
    await _audioPlayer.play(AssetSource(caminho));
  }

  Future<void> pararAudio() async {
    await _audioPlayer.stop();
  }

  Future<void> pausarAudio() async {
    await _audioPlayer.pause();
  }

  Future<void> resumirAudio() async {
    await _audioPlayer.resume();
  }

  Future<void> ajustarVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
  }
}
