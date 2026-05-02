import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioHandlerImpl extends BaseAudioHandler {
  final AudioPlayer _audioPlayer = AudioPlayer();

  AudioHandlerImpl() {
    _audioPlayer.playingStream.listen((playing) {
      playbackState.add(playbackState.value.copyWith(playing: playing));
    });
  }

  @override
  Future<void> play() async {
    await _audioPlayer.play();
  }

  @override
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  @override
  Future<void> stop() async {
    await _audioPlayer.stop();
  }
}
