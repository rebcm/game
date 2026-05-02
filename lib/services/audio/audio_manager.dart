import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioManager {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioService _audioService = AudioService();

  Future<void> init() async {
    await _audioPlayer.setAsset('assets/audio/optimized/music/main_theme.mp3');
    await _audioService.start(
      backgroundTaskInit: () async {
        return await AudioServiceBackground.run(
          child: AudioServiceBackgroundChild(),
          androidNotificationChannelName: 'Rebeca Game',
          androidNotificationColor: 0xFF2196f3,
          androidNotificationIcon: 'drawable/ic_stat_notification',
        );
      },
    );
  }

  void play() {
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void stop() {
    _audioPlayer.stop();
  }
}

class AudioServiceBackgroundChild extends BackgroundAudioTask {
  @override
  Future<void> onStart(Map<String, dynamic> params) async {}

  @override
  Future<void> onStop() async {}

  @override
  Future<void> onPlay() async {}

  @override
  Future<void> onPause() async {}

  @override
  Future<void> onSeekTo(Duration position) async {}
}
