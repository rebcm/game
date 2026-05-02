import 'package:just_audio/just_audio.dart';
import 'package:audio_service/audio_service.dart';

class AudioManager {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioService _audioService = AudioService();

  Future<void> initAudio() async {
    await _audioPlayer.setAsset('assets/audio/optimized/music/main_theme.mp3');
    await _audioService.start(
      backgroundTaskId: 'audio_task',
      config: AudioServiceConfig(
        androidNotificationChannelId: 'com.rebcm.game.audio',
        androidNotificationChannelName: 'Rebeca\'s World Audio',
      ),
    );
  }

  void playBackgroundMusic() {
    _audioPlayer.play();
  }

  void pauseBackgroundMusic() {
    _audioPlayer.pause();
  }

  void stopBackgroundMusic() {
    _audioPlayer.stop();
  }
}
