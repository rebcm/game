import 'package:audioplayers/audioplayers.dart';
class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Future<void> playAudio(String url) async {
    await _audioPlayer.play(UrlSource(url));
  }
  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }
}
