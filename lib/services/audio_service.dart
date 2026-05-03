import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playAudio(String audioPath) async {
    await _audioPlayer.play(AssetSource(audioPath));
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
    await _audioPlayer.dispose();
  }
}
