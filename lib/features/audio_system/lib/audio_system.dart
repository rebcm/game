library audio_system;
import 'package:audioplayers/audioplayers.dart';
class AudioSystem {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Future<void> playAudio(String url) async {
    await _audioPlayer.play(UrlSource(url));
  }
}
