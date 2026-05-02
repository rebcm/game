import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioServiceImpl {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playSound(String soundFile) async {
    await _audioPlayer.setAsset('assets/audio/optimized/sfx/$soundFile');
    await _audioPlayer.play();
  }

  Future<void> playAmbient(String ambientFile) async {
    await _audioPlayer.setAsset('assets/audio/optimized/ambient/$ambientFile');
    await _audioPlayer.play();
    await _audioPlayer.setLoopMode(LoopMode.one);
  }

  Future<void> stopSound() async {
    await _audioPlayer.stop();
  }
}
