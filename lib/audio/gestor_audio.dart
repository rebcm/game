import 'package:audioplayers/audioplayers.dart';

class GestorAudio {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> carregarAudio() async {
    await _audioPlayer.setSource(AssetSource('audio_optimized/music/dia_01.opus'));
  }

  Future<void> tocarAudio() async {
    await _audioPlayer.resume();
  }
}
