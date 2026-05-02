import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioServiceImpl {
  final AudioPlayer _audioPlayer;

  AudioServiceImpl(this._audioPlayer);

  void playAmbient(String ambientPath) async {
    await _audioPlayer.setAsset(ambientPath);
    _audioPlayer.play();
  }

  void stopAmbient() async {
    await _audioPlayer.stop();
  }
}
